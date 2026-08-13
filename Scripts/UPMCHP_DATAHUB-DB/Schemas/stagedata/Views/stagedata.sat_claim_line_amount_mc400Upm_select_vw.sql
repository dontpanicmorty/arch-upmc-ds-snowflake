CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_AMOUNT_MC400UPM_SELECT_VW
COMMENT='This is a SAT View containing Claim Line Amount data'
AS
WITH 
appermanentPayment_CTE
AS
(
    --TPA might need added to this is some way, but it should be ok for now
    SELECT --mc400 logic because the data is junk!
    tpaRowId, rowId, tableRowId, IFF(fileType = 'H','I',fileType) AS fileType, checkNbr, checkDate, postDate, status
    FROM RAWDATA.MC400_DWOAO_APPERMANENTPAYMENT
    QUALIFY DENSE_RANK() OVER(PARTITION BY tpaRowId, tableRowId, fileType ORDER BY sysGenId) = 1
)

,apWork_CTE
AS
(
    SELECT  --mc400 logic because the data is junk!
    tpaRowId, rowId, filetype, IFF(fileType = 'I', hinsdprowid, hencdprowid) as tableRowId, status, postDate
    FROM RAWDATA.MC400_DWOAO_APWORK
    QUALIFY DENSE_RANK() OVER(PARTITION BY tpaRowId, fileType, tableRowId ORDER BY sysGenId, ChgOrig) = 1
)

SELECT
ClaimsDetail.TpaClient AS TPA_CLIENT_ID
,ClaimsDetail.TpaIdOfClient AS TPA_ID
,ClaimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.ClaimNbr AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,ClaimsDetail.AllowedAmt AS ALLOWED_AMOUNT
,ClaimsDetail.BilledAmt AS CHARGE_AMOUNT
,ClaimsDetail.Amount1 AS CLAIM_AMT_01
,ClaimsDetail.Amount1Type AS CLAIM_AMT_01_DESC
,ClaimsDetail.Amount2 AS CLAIM_AMT_02
,ClaimsDetail.Amount2Type AS CLAIM_AMT_02_DESC
,ClaimsDetail.CopayAmt AS COPAY_AMT_01
,ClaimsDetail.CoPayAmt2 AS COPAY_AMT_02
,ClaimsDetail.CoPayAmt3 as COPAY_AMT_03
,ClaimsDetail.DeductAmt AS DEDUCTIBLE_AMOUNT
,ClaimsDetail.NotCoveredAmt AS NOT_COVERED_AMOUNT
,(ClaimsDetail.NetAmt - ClaimsDetail.PayForPerformance) AS PAID_AMOUNT
,ClaimsDetail.NetAmt AS PAID_GROSS_AMOUNT
,ClaimsDetail.PayForPerformance AS PAY_FOR_PERFORMANCE_AMOUNT
,ClaimsDetail.WithHoldAmt AS WITHHOLD_AMOUNT
,ClaimsDetail.CoInsuranceAmt AS COINSURANCE_AMOUNT
,CodeReviewOrigBilledAmt AS CODE_REVIEW_ORIGINAL_BILLING_AMOUNT
,CodeReviewOriginalNetAmt AS CODE_REVIEW_ORIGINAL_NET_AMOUNT
,NULL AS APPROVED_AMT --Does not exist for UPM
,COALESCE(apPermanentPaymentGl.glAmount, apWorkGl.glAmount, ClaimsDetail.InterestDiscountAmt) AS INTEREST_DISCOUNT_AMOUNT
,ClaimsDetail.oicPaidAmount AS THIRD_PARTY_PAID_AMOUNT
,ClaimsDetail.oicAllowedAmount AS THIRD_PARTY_ALLOWED_AMOUNT
,ClaimsDetail.oicPaidAmount AS OIC_PAID_AMOUNT
,ClaimsDetail.oicAllowedAmount AS OIC_ALLOWED_AMOUNT
,CASE 
    WHEN ClaimsDetail.Amount1Type = 'HRA' THEN ClaimsDetail.Amount1
    WHEN ClaimsDetail.Amount2Type = 'HRA' THEN ClaimsDetail.Amount2
    ELSE 0
END AS HRA_APPLIED_AMT,
CASE WHEN ClaimsDetail.Amount1Type = 'HIA' THEN ClaimsDetail.Amount1
     WHEN ClaimsDetail.Amount2Type = 'HIA' THEN ClaimsDetail.Amount2
     ELSE 0 
END AS HIA_APPLIED_AMT
,NULL AS MEMBER_PAY_FLAG
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,UTIL.FXN_ARRAY_HASH([
    ALLOWED_AMOUNT
    ,CHARGE_AMOUNT
    ,CLAIM_AMT_01
    ,CLAIM_AMT_01_DESC
    ,CLAIM_AMT_02
    ,CLAIM_AMT_02_DESC
    ,COPAY_AMT_01
    ,COPAY_AMT_02
    ,COPAY_AMT_03
    ,DEDUCTIBLE_AMOUNT
    ,NOT_COVERED_AMOUNT
    ,PAID_AMOUNT
    ,PAID_GROSS_AMOUNT
    ,PAY_FOR_PERFORMANCE_AMOUNT
    ,WITHHOLD_AMOUNT
    ,COINSURANCE_AMOUNT
    ,CODE_REVIEW_ORIGINAL_BILLING_AMOUNT
    ,CODE_REVIEW_ORIGINAL_NET_AMOUNT
    ,APPROVED_AMT
    ,INTEREST_DISCOUNT_AMOUNT
    ,THIRD_PARTY_PAID_AMOUNT
    ,THIRD_PARTY_ALLOWED_AMOUNT
    ,OIC_PAID_AMOUNT
    ,OIC_ALLOWED_AMOUNT
    ,HRA_APPLIED_AMT
    ,HIA_APPLIED_AMT
    ,MEMBER_PAY_FLAG
]) AS HASH_DIFF

FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL claimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr
        AND claims.memberNbr <> '99999999901') --Exclude Generic Default Member Claims

    --TPA might need added to this is some way, but it should be ok for now
    LEFT OUTER JOIN appermanentPayment_CTE
        ON (appermanentPayment_CTE.tableRowId = claimsDetail.rowId
        AND appermanentPayment_CTE.fileType = claimsDetail.claimType)

    LEFT OUTER JOIN RAWDATA.MC400_DWOAO_APPERMANENTPAYMENTGL apPermanentPaymentGl
        ON (apPermanentPaymentGl.tpaRowId = appermanentPayment_CTE.tpaRowId
        AND apPermanentPaymentGl.apPaypRowId = appermanentPayment_CTE.rowId
        AND apPermanentPaymentGl.glType = 'INT')

    --TPA might need added to this is some way, but it should be ok for now
    LEFT OUTER JOIN apWork_CTE
        ON (apWork_CTE.fileType = claimsDetail.claimType
        AND apWork_CTE.tableRowId = claimsDetail.rowId)
    
    LEFT OUTER JOIN RAWDATA.MC400_DWOAO_APWORKGL apWorkGl
        ON (apWorkGl.tpaRowId = apWork_CTE.tpaRowId
        AND apWorkGl.apWorkpRowId = apWork_CTE.rowId
        AND apWorkGl.glType = 'INT')
            
;
