CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_MC400UPM_SELECT_VW
COMMENT='This is the select view to SAT_CLAIM_LINE for the MC400Upm Data Source'
AS
WITH 
appermanentPayment_CTE
AS
(
    --TPA might need added to this is some way, but it should be ok for now
    SELECT --mc400 logic because the data is junk!
    tableRowId, IFF(fileType = 'H','I',fileType) AS fileType, checkNbr, checkDate, postDate, status
    FROM RAWDATA.MC400_DWOAO_APPERMANENTPAYMENT
    QUALIFY DENSE_RANK() OVER(PARTITION BY tpaRowId, tableRowId, fileType ORDER BY sysGenId) = 1
)

,apWork_CTE
AS
(
    SELECT  --mc400 logic because the data is junk!
    tpaRowId, filetype, IFF(fileType = 'I', hinsdprowid, hencdprowid) as tableRowId, status, postDate
    FROM RAWDATA.MC400_DWOAO_APWORK
    QUALIFY DENSE_RANK() OVER(PARTITION BY tpaRowId, fileType, tableRowId ORDER BY sysGenId, ChgOrig) = 1
)
,PROCEDURECODES_CTE AS --list of distinct codes in PROCEDURECODES table
(SELECT DISTINCT TRIM(CODE) AS CODE
FROM RAWDATA.MC400_DWOAO_PROCEDURECODES
)

,SERVICE_TYPE_CODE_CTE AS ( --set SERVICE_TYPE_CODE at claim level
    SELECT DISTINCT 
       MC400_DWOAO_CLAIMS.TPACLIENT
       ,MC400_DWOAO_CLAIMS.TPAIDOFCLIENT
       ,MC400_DWOAO_CLAIMS.TPADIVISION
       ,'MC400Upm' AS DATA_SOURCE_NAME
       ,MC400_DWOAO_CLAIMS.CLAIMNBR
       ,MAX(CASE WHEN IFF(TRIM(MC400_DWOAO_CLAIMSDETAIL.ServiceReason) = '', NULL, TRIM(MC400_DWOAO_CLAIMSDETAIL.ServiceReason)) = 'LL' THEN '1' ELSE '0' END) AS CLAIM_LEVEL_SERVICE_REASON_IND
       ,CASE
            MAX(CASE
                STAGEDATA.FXN_GET_SERVICE_TYPE_CODE_MC400(DATA_SOURCE_NAME, MC400_DWOAO_CLAIMSDETAIL.ProviderTypeHCFA, MC400_DWOAO_CLAIMSDETAIL.RevenueCode)
                    WHEN 'F' THEN 4
                    WHEN 'P' THEN 3
                    WHEN 'SM' THEN 2
                    WHEN 'U' THEN 1
                END)
            WHEN 4 THEN 'F'
            WHEN 3 THEN 'P'
            WHEN 2 THEN 'SM'
            WHEN 1 THEN 'U'
        END AS SERVICE_TYPE_CODE
FROM RAWDATA.MC400_DWOAO_CLAIMS
JOIN RAWDATA.MC400_DWOAO_CLAIMSDETAIL
    ON (MC400_DWOAO_CLAIMS.TPACLIENT = MC400_DWOAO_CLAIMSDETAIL.TPACLIENT
    AND MC400_DWOAO_CLAIMS.TPAIDOFCLIENT = MC400_DWOAO_CLAIMSDETAIL.TPAIDOFCLIENT
    AND MC400_DWOAO_CLAIMS.TPADIVISION = MC400_DWOAO_CLAIMSDETAIL.TPADIVISION
    AND MC400_DWOAO_CLAIMS.CLAIMNBR = MC400_DWOAO_CLAIMSDETAIL.CLAIMNBR
    AND MC400_DWOAO_CLAIMS.MEMBERNBR <> '99999999901')
GROUP BY MC400_DWOAO_CLAIMS.TPACLIENT, MC400_DWOAO_CLAIMS.TPAIDOFCLIENT, MC400_DWOAO_CLAIMS.TPADIVISION, MC400_DWOAO_CLAIMS.CLAIMNBR
)

, LOCATION_TYPE_CODE_CTE AS ( --set LOCATION_TYPE_CODE at claim level)
    SELECT DISTINCT 
    TPACLIENT,
    TPAIDOFCLIENT,
    TPADIVISION,
    CLAIMNBR,
CASE
            MAX(
            CASE LOCATION_TYPE_CODE
                    WHEN 'I' THEN 3
                    WHEN 'O' THEN 2
                    WHEN 'U' THEN 1
                END)
            WHEN 3 THEN 'I'
            WHEN 2 THEN 'O'
            WHEN 1 THEN 'U'
        END AS LOCATION_CODE
FROM (
SELECT DISTINCT
MC400_DWOAO_CLAIMS.TPACLIENT,
MC400_DWOAO_CLAIMS.TPAIDOFCLIENT,
MC400_DWOAO_CLAIMS.TPADIVISION,
'MC400Upm' AS DATA_SOURCE_NAME,
MC400_DWOAO_CLAIMS.CLAIMNBR,
SERVICE_TYPE_CODE_CTE.SERVICE_TYPE_CODE,
IFF(TRIM(MC400_DWOAO_CLAIMSDETAIL.ServiceReason) = '', NULL, TRIM(MC400_DWOAO_CLAIMSDETAIL.ServiceReason)) AS SERVICE_REASON_CODE,
CASE
            MAX(
            CASE STAGEDATA.FXN_GET_LOCATION_CODE_MC400(DATA_SOURCE_NAME, SERVICE_TYPE_CODE, SERVICE_TYPE_CODE_CTE.CLAIM_LEVEL_SERVICE_REASON_IND, CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL.LOCATION_TYPE_CODE, TRIM(MC400_DWOAO_CLAIMSDETAIL.REVENUECODE))
                    WHEN 'I' THEN 3
                    WHEN 'O' THEN 2
                    WHEN 'U' THEN 1
                END)
            WHEN 3 THEN 'I'
            WHEN 2 THEN 'O'
            WHEN 1 THEN 'U'
        END AS LOCATION_TYPE_CODE

FROM RAWDATA.MC400_DWOAO_CLAIMS
JOIN RAWDATA.MC400_DWOAO_CLAIMSDETAIL
    ON (MC400_DWOAO_CLAIMS.TPACLIENT = MC400_DWOAO_CLAIMSDETAIL.TPACLIENT
    AND MC400_DWOAO_CLAIMS.TPAIDOFCLIENT = MC400_DWOAO_CLAIMSDETAIL.TPAIDOFCLIENT
    AND MC400_DWOAO_CLAIMS.TPADIVISION = MC400_DWOAO_CLAIMSDETAIL.TPADIVISION
    AND MC400_DWOAO_CLAIMS.CLAIMNBR = MC400_DWOAO_CLAIMSDETAIL.CLAIMNBR
    AND MC400_DWOAO_CLAIMS.MEMBERNBR <> '99999999901')
JOIN SERVICE_TYPE_CODE_CTE
    ON (SERVICE_TYPE_CODE_CTE.TPACLIENT = MC400_DWOAO_CLAIMS.TPACLIENT
    AND SERVICE_TYPE_CODE_CTE.TPAIDOFCLIENT = MC400_DWOAO_CLAIMS.TPAIDOFCLIENT
    AND SERVICE_TYPE_CODE_CTE.TPADIVISION = MC400_DWOAO_CLAIMS.TPADIVISION
    AND SERVICE_TYPE_CODE_CTE.CLAIMNBR = MC400_DWOAO_CLAIMS.CLAIMNBR)
LEFT OUTER JOIN REFDATA.CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL
        ON (CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL.PLACE_OF_SERVICE_CODE = MC400_DWOAO_CLAIMSDETAIL.PlaceOfService)
GROUP BY MC400_DWOAO_CLAIMS.TPACLIENT, MC400_DWOAO_CLAIMS.TPAIDOFCLIENT, MC400_DWOAO_CLAIMS.TPADIVISION, MC400_DWOAO_CLAIMS.CLAIMNBR, SERVICE_TYPE_CODE, SERVICE_REASON_CODE, CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL.LOCATION_TYPE_CODE, MC400_DWOAO_CLAIMSDETAIL.REVENUECODE
)
GROUP BY TPACLIENT, TPAIDOFCLIENT, TPADIVISION, CLAIMNBR
)

SELECT DISTINCT 
ClaimsDetail.TPACLIENT AS TPA_CLIENT_ID
,ClaimsDetail.TPAIDOFCLIENT AS TPA_ID
,ClaimsDetail.TPADIVISION AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.ClaimNbr AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,ClaimsDetail.ClaimType AS CLAIM_TYPE_CODE --(E)ncounter or (I)npatient, different from claimTypeCode on ClaimsDetail
,TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.ClaimReceiveDate),'YYYYMMDD') AS CLAIM_RECEIVED_DATE
,CASE
    WHEN CPT_LOOKUP.CODE IS NOT NULL THEN TRIM(ClaimsDetail.ProcedureCode) --If PROCEDURECODE is a valid procedure code (5-character alphanumeric string), then bring it forward
    WHEN HCPCS_LOOKUP.CODE IS NOT NULL THEN TRIM(ClaimsDetail.HCPCS) --If HCPCS is a valid procedure code (5-character alphanumeric string), then bring it forward 
    WHEN REVENUE_CODE_LOOKUP.CODE IS NOT NULL THEN NULL --If the ProcedureCode is actually a revenue code (4-character numeric string), then NULL
    ELSE IFF(TRIM(ClaimsDetail.ProcedureCode)='',NULL,TRIM(ClaimsDetail.ProcedureCode)) --ELSE bring forward PROCEDURECODE, converting empty strings to nulls
END AS PROCEDURE_CODE
,ClaimsDetail.ProcedureQty AS PROCEDURE_QUANTITY
,TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.SpecificDateOfService),'YYYYMMDD') AS SERVICE_BEGIN_DATE
,IFF(ClaimsDetail.SpecificDateOfServiceThru = 0, TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.SpecificDateOfService),'YYYYMMDD'), TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.SpecificDateOfServiceThru),'YYYYMMDD')) AS SERVICE_END_DATE
,TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.AddDate),'YYYYMMDD') AS ADD_DATE
,COALESCE(
    IFF(TRIM(appermanentPayment_CTE.status) = '', NULL, TRIM(appermanentPayment_CTE.status)),
    IFF(TRIM(apWork_CTE.status) = '', NULL, TRIM(apWork_CTE.status))
) AS ACCOUNTS_PAYABLE_PAY_STATUS_CODE
,IFF(TRIM(ClaimsDetail.AdjudicationStatus) = '', NULL, TRIM(ClaimsDetail.AdjudicationStatus)) AS ADJUDICATION_STATUS
,COALESCE(
    TRY_TO_DATE(TO_VARCHAR(appermanentPayment_CTE.postDate), 'YYYYMMDD'),
    TRY_TO_DATE(TO_VARCHAR(apWork_CTE.postDate), 'YYYYMMDD'),
    TRY_TO_DATE(TO_VARCHAR(claimsDetail.apPostingDate), 'YYYYMMDD')
) AS AP_POSTING_DATE
,IFF(TRIM(ClaimsDetail.BenefitCategory) = '', NULL, TRIM(ClaimsDetail.BenefitCategory)) AS BENEFIT_CATEGORY_CODE
,IFF(TRIM(ClaimsDetail.BenefitLevel) = '', NULL, ClaimsDetail.BenefitLevel) AS BENEFIT_LEVEL_CODE
,TO_BOOLEAN(ClaimsDetail.BucketStatus) AS BUCKET_STATUS_FLAG
,COALESCE(
    TRY_TO_DATE(TO_VARCHAR(appermanentPayment_CTE.CheckDate),'YYYYMMDD'),
    TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.CheckDate),'YYYYMMDD')
) AS CHECK_DATE
,COALESCE(
    IFF(TRIM(appermanentPayment_CTE.checkNbr) = '', NULL, TRIM(appermanentPayment_CTE.checkNbr)),
    IFF(TRIM(ClaimsDetail.CheckNbr) = '', NULL, TRIM(ClaimsDetail.CheckNbr))
) AS CHECK_NUMBER
,CASE 
    WHEN (claimsdetail.revenuecode = '0022'
         AND claimsdetail.placeofservice = '31')
         OR (
                (claimsdetail.procedurecode BETWEEN '0100' AND '0219')
                OR (claimsdetail.revenuecode BETWEEN '0100' AND '0219')
             )
         AND (claimsdetail.notcoveredamt = 0 OR claimsdetail.notcoveredreason = 'PN')
         AND (
                (claims.DRGcode <> '391' AND NULLIF(claims.dischargedate,0) <  20071001)
         OR
         (claims.DRGcode <> '795' AND NULLIF(claims.dischargedate,0) >= 20070101)
             )
         AND claimsdetail.servicereason <> 'LL'
    THEN claimsdetail.procedureQty
    ELSE 0
END AS CLAIM_DAY_CNT
,IFF(TRIM(ClaimsDetail.CleanClaimIndicator) = '', NULL, TRIM(ClaimsDetail.CleanClaimIndicator)) AS CLEAN_CLAIM_IND
,IFF(TRIM(ClaimsDetail.CompanyCode) = '', NULL, TRIM(ClaimsDetail.CompanyCode)) AS COMPANY_CODE
,NULL AS DENIED_DAY_CNT --logic needs determined and revisted (talk with DOHE)
,IFF(TRIM(ELIGIBILITYHISTORY.MiscStatusCode) = '', NULL, TRIM(ELIGIBILITYHISTORY.MiscStatusCode))  AS ELIGIBILITY_MISC_STATUS_CODE
,ClaimsDetail.FormNbr AS FORM_NUMBER
,IFF(TRIM(ClaimsDetail.GlDistributionCode) = '', NULL, TRIM(ClaimsDetail.GlDistributionCode)) AS GL_DISTRIBUTION_CODE
,NULL AS IS_PROCESSING_COMPLETE --marklogic specific column, needs removed
,TRIM(ClaimsDetail.KeyToSourceFile) AS KEY_TO_SOURCE_FILE
,SERVICE_TYPE_CODE_CTE.SERVICE_TYPE_CODE --claim_level SERVICE_TYPE_CODE from CTE
,LOCATION_TYPE_CODE_CTE.LOCATION_CODE --claim_level SERVICE_TYPE_CODE from CTE
,COALESCE(
    IFF(TRIM(appermanentPayment_CTE.status) = '', NULL, TRIM(appermanentPayment_CTE.status)),
    IFF(TRIM(apWork_CTE.status) = '', NULL, TRIM(apWork_CTE.status)),
    IFF(TRIM(ClaimsDetail.PayStatus) = '', NULL, TRIM(ClaimsDetail.PayStatus))
) AS PAY_STATUS_CODE
,COALESCE(
    TRY_TO_DATE(TO_VARCHAR(appermanentPayment_CTE.CheckDate),'YYYYMMDD'),
    TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.CheckDate),'YYYYMMDD')
) AS PAYMENT_DATE
,NULL AS TOOTH_QUADRANT --only applies to dental claims
,CASE
    WHEN REGEXP_LIKE(LPAD(TRIM(claimsDetail.RevenueCode),4,'0'),'^[0-9]{4}$') AND LEN(TRIM(claimsDetail.RevenueCode)) BETWEEN 1 AND 4 THEN LPAD(TRIM(claimsDetail.RevenueCode),4,'0') --If RevenueCode is a valid revenue code (4-character numeric string) when LPADDED, and RevenueCode is 1-4 characters long (removes empty strings and five-character alphanumeric codes beginning with 4 numbers) then bring the LPADDED version of RevenueCode forward
    WHEN REVENUE_CODE_LOOKUP.CODE IS NOT NULL AND LEN(TRIM(claimsDetail.ProcedureCode)) BETWEEN 1 AND 4 THEN LPAD(TRIM(claimsDetail.ProcedureCode),4,'0') --If ProcedureCode is a valid revenue code (4-character numeric string) when LPADDED, and ProcedureCode is 1-4 characters long (removes empty strings and five-character alphanumeric codes beginning with 4 numbers) then bring the LPADDED version of ProcedureCode forward
    ELSE IFF(TRIM(ClaimsDetail.RevenueCode)='',NULL,TRIM(ClaimsDetail.RevenueCode)) --Else, bring RevenueCode forward, converting empty strings to nulls
END AS REVENUE_CODE
,STAGEDATA.FXN_GET_SERVICE_CNT_MC400(DATA_SOURCE_NAME, PROCEDURE_CODE, ClaimsDetail.ProcedureQty) AS SERVICE_CNT
,IFF(TRIM(ClaimsDetail.ServiceReason) = '', NULL, TRIM(ClaimsDetail.ServiceReason)) AS SERVICE_REASON_CODE
,CASE
    WHEN (ClaimsDetail.AllowedAmt = ClaimsDetail.NotCoveredAmt AND ClaimsDetail.NotCoveredAmt <> 0)
        THEN 'D'
    ELSE 
        CASE
            WHEN (ClaimsDetail.NetAmt - ClaimsDetail.PayForPerformance) <> 0 OR ClaimsDetail.CoPayAmt <> 0 OR ClaimsDetail.DeDuctAmt <> 0
                OR (ClaimsDetail.AllowedAmt <> 0 AND ClaimsDetail.AllowedAmt <> ClaimsDetail.NotCoveredAmt)
                OR (ClaimsDetail.OicAllowedAmount <> 0 AND ClaimsDetail.NotCoveredAmt = 0)
            THEN 'P'
        ELSE
            'D'
        END
END AS SERVICE_STATUS_CODE
,IFF(SERVICE_STATUS_CODE = 'P','Paid','Denied') AS SERVICE_STATUS_DESC
,IFF(ClaimsDetail.ProcedureAdj LIKE '%R%','A','C') AS TRANSACTION_TYPE_CODE
,IFF(ClaimsDetail.ProcedureAdj LIKE '%R%','Adjustment','Charge') AS TRANSACTION_TYPE_DESC
,ClaimsDetail.LastUpdated AS SOURCE_LAST_UPDATED_DATETIME
,NULL AS TOOTH_ID --dental claims only
,NULL AS TOOTH_ARCH --dental claims only
,Claims.MemberAge AS MEMBER_AGE_NBR
,NULL AS AUTHORIZATION_NBR
,TO_ARRAY(NULL) AS TOOTH_SURFACE_ARRAY --dental claims only
,IFF(TRIM(ClaimsDetail.HCPCS)='',NULL,TRIM(ClaimsDetail.HCPCS)) AS HCPCS_CODE --Bring HCPCS forward, converting empty strings to nulls
,CASE
    WHEN ROW_NUMBER() OVER(PARTITION BY CLAIM_NBR, CLAIM_LINE_NBR ORDER BY CLAIM_LINE_SEQ_NBR DESC) = 1 THEN TRUE
    ELSE FALSE
END AS CMS_CURRENT_ITERATION_FLAG
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,UTIL.FXN_ARRAY_HASH(
    [CLAIM_TYPE_CODE
    ,CLAIM_RECEIVED_DATE
    ,PROCEDURE_CODE
    ,PROCEDURE_QUANTITY
    ,SERVICE_BEGIN_DATE
    ,SERVICE_END_DATE
    ,ADD_DATE
    ,ACCOUNTS_PAYABLE_PAY_STATUS_CODE
    ,ADJUDICATION_STATUS
    ,AP_POSTING_DATE
    ,BENEFIT_CATEGORY_CODE
    ,BENEFIT_LEVEL_CODE
    ,BUCKET_STATUS_FLAG
    ,CHECK_DATE
    ,CHECK_NUMBER
    ,CLAIM_DAY_CNT
    ,CLEAN_CLAIM_IND
    ,COMPANY_CODE
    ,DENIED_DAY_CNT
    ,ELIGIBILITY_MISC_STATUS_CODE
    ,FORM_NUMBER
    ,GL_DISTRIBUTION_CODE
    ,IS_PROCESSING_COMPLETE
    ,KEY_TO_SOURCE_FILE
    ,LOCATION_CODE
    ,PAY_STATUS_CODE
    ,PAYMENT_DATE 
    ,TOOTH_QUADRANT
    ,REVENUE_CODE
    ,SERVICE_CNT
    ,SERVICE_REASON_CODE
    ,SERVICE_STATUS_CODE
    ,SERVICE_STATUS_DESC
    ,SERVICE_TYPE_CODE
    ,TRANSACTION_TYPE_CODE
    ,TRANSACTION_TYPE_DESC
    ,SOURCE_LAST_UPDATED_DATETIME
    ,TOOTH_ID
    ,TOOTH_ARCH
    ,MEMBER_AGE_NBR
    ,AUTHORIZATION_NBR
    ,TOOTH_SURFACE_ARRAY
    ,HCPCS_CODE
    ,CMS_CURRENT_ITERATION_FLAG]
) AS HASH_DIFF

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

    --TPA might need added to this is some way, but it should be ok for now
    LEFT OUTER JOIN apWork_CTE
        ON (apWork_CTE.fileType = claimsDetail.claimType
        AND apWork_CTE.tableRowId = claimsDetail.rowId)
    
    LEFT OUTER JOIN SERVICE_TYPE_CODE_CTE
        ON (SERVICE_TYPE_CODE_CTE.TPACLIENT = CLAIMS.TPACLIENT
        AND SERVICE_TYPE_CODE_CTE.TPAIDOFCLIENT = CLAIMS.TPAIDOFCLIENT
        AND SERVICE_TYPE_CODE_CTE.TPADIVISION = CLAIMS.TPADIVISION
        AND SERVICE_TYPE_CODE_CTE.CLAIMNBR = CLAIMS.CLAIMNBR)

    LEFT OUTER JOIN LOCATION_TYPE_CODE_CTE
        ON (LOCATION_TYPE_CODE_CTE.TPACLIENT = CLAIMS.TPACLIENT
        AND LOCATION_TYPE_CODE_CTE.TPAIDOFCLIENT = CLAIMS.TPAIDOFCLIENT
        AND LOCATION_TYPE_CODE_CTE.TPADIVISION = CLAIMS.TPADIVISION
        AND LOCATION_TYPE_CODE_CTE.CLAIMNBR = CLAIMS.CLAIMNBR)

    LEFT OUTER JOIN RAWDATA.MC400_DWOAO_ELIGIBILITYHISTORY eligibilityHistory
        ON (eligibilityHistory.tpaClient = claimsDetail.tpaClient
        AND eligibilityHistory.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND eligibilityHistory.tpaDivision - claimsDetail.tpaDivision
        AND eligibilityHistory.MemberNbr = ClaimsDetail.MemberNbr
        AND eligibilityHistory.EligibilityStartDate <= ClaimsDetail.SpecificDateOfService
        AND IFF(eligibilityHistory.EligibilityEndDate = 0, 99991231, eligibilityHistory.EligibilityEndDate) >= ClaimsDetail.SpecificDateOfService)

    LEFT OUTER JOIN REFDATA.CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL
        ON (CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL.PLACE_OF_SERVICE_CODE = ClaimsDetail.PlaceOfService)

    LEFT OUTER JOIN PROCEDURECODES_CTE CPT_LOOKUP --look up PROCEDURECODE in DWOAO.PROCEDURECODES table to determine if it is a legitimate CPT procedure code (5-character alphanumeric string)
        ON (IFF(LEN(TRIM(claimsDetail.ProcedureCode)) < 4, LPAD(TRIM(claimsDetail.ProcedureCode),4,'0'), TRIM(claimsDetail.ProcedureCode)) = CPT_LOOKUP.CODE
        AND REGEXP_LIKE(CPT_LOOKUP.CODE, '^[a-zA-Z0-9]{5}$'))
 
    LEFT OUTER JOIN PROCEDURECODES_CTE REVENUE_CODE_LOOKUP -- look up PROCEDURECODE in DWOAO.PROCEDURECODES table to determine if it is a legitimate revenue code (5-character numeric string)
        ON (IFF(LEN(TRIM(claimsDetail.ProcedureCode)) < 4, LPAD(TRIM(claimsDetail.ProcedureCode),4,'0'), TRIM(claimsDetail.ProcedureCode)) = REVENUE_CODE_LOOKUP.CODE
        AND REGEXP_LIKE(REVENUE_CODE_LOOKUP.CODE,'^[0-9]{4}$'))

    LEFT OUTER JOIN PROCEDURECODES_CTE HCPCS_LOOKUP --look up HCPCS in DWOAO.PROCEDURECODES table to determine if it is a legitimate procedure code (5-character alphanumeric string)
        ON (TRIM(claimsDetail.HCPCS) = HCPCS_LOOKUP.CODE
        AND REGEXP_LIKE(HCPCS_LOOKUP.CODE, '^[a-zA-Z0-9]{5}$'))
;