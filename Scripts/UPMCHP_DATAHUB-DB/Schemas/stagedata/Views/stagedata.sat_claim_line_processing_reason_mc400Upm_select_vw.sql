
CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_PROCESSING_REASON_MC400UPM_SELECT_VW 
COMMENT = 'This is a SAT View containing Claim Line processing reason data'
AS
SELECT
ClaimsDetail.tpaClient AS TPA_CLIENT_ID
,ClaimsDetail.tpaIdOfClient AS TPA_ID
,ClaimsDetail.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.CLAIMNBR AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,'CoPay' AS REASON_TYPE_CODE
,1 AS CODE_POSITION
,TRIM(ClaimsDetail.CoPayReason) AS REASON_CODE
,UTIL.FXN_ARRAY_HASH([REASON_CODE]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE ClaimsDetail.CoPayReason <> ''
AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims

UNION ALL

SELECT
ClaimsDetail.tpaClient AS TPA_CLIENT_ID
,ClaimsDetail.tpaIdOfClient AS TPA_ID
,ClaimsDetail.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.CLAIMNBR AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,'Deductible' AS REASON_TYPE_CODE
,1 AS CODE_POSITION
,TRIM(ClaimsDetail.DeductibleReason) AS REASON_CODE
,UTIL.FXN_ARRAY_HASH([REASON_CODE]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE DeductibleReason <> ''
AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims

UNION ALL

SELECT
ClaimsDetail.tpaClient AS TPA_CLIENT_ID
,ClaimsDetail.tpaIdOfClient AS TPA_ID
,ClaimsDetail.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.CLAIMNBR AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,'CoInsurance' AS REASON_TYPE_CODE
,1 AS CODE_POSITION
,TRIM(ClaimsDetail.CoInsuranceReason) AS REASON_CODE
,UTIL.FXN_ARRAY_HASH([REASON_CODE]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE CoInsuranceReason <> ''
AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims

UNION ALL

SELECT
ClaimsDetail.tpaClient AS TPA_CLIENT_ID
,ClaimsDetail.tpaIdOfClient AS TPA_ID
,ClaimsDetail.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.CLAIMNBR AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,'Service' AS REASON_TYPE_CODE
,1 AS CODE_POSITION
,TRIM(ClaimsDetail.ServiceReason) AS REASON_CODE
,UTIL.FXN_ARRAY_HASH([REASON_CODE]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE ServiceReason <> ''
AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims

UNION ALL

// need to union both adjustment reason fields together to insure we get a distinct list and the same code appears in both fields at times
SELECT
TPA_CLIENT_ID
,TPA_ID
,TPA_DIV_ID
,DATA_SOURCE_NAME
,CLAIM_NBR
,CLAIM_LINE_NBR
,CLAIM_LINE_SEQ_NBR
,CLAIM_LINE_PROCEDURE_ADJ_CODE
,HUB_CLAIM_DETAIL_HKEY
,REASON_TYPE_CODE
,CODE_POSITION
,REASON_CODE
,HASH_DIFF
FROM (

      SELECT
      ClaimsDetail.tpaClient AS TPA_CLIENT_ID
      ,ClaimsDetail.tpaIdOfClient AS TPA_ID
      ,ClaimsDetail.tpaDivision AS TPA_DIV_ID
      ,'MC400Upm' AS DATA_SOURCE_NAME
      ,ClaimsDetail.CLAIMNBR AS CLAIM_NBR
      ,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
      ,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
      ,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
      ,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
      ,'Adjustment' AS REASON_TYPE_CODE
      ,1 AS CODE_POSITION
      ,TRIM(ClaimsDetail.AdjustmentReason1) AS REASON_CODE
      ,UTIL.FXN_ARRAY_HASH([REASON_CODE]) AS HASH_DIFF
      FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
        JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
            ON (claims.tpaClient = claimsDetail.tpaClient
            AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
            AND claims.tpaDivision = claimsDetail.tpaDivision
            AND claims.claimNbr = claimsDetail.claimNbr)
      WHERE AdjustmentReason1 <> ''
      AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims

      UNION -- get distinct list 

      SELECT
      ClaimsDetail.tpaClient AS TPA_CLIENT_ID
      ,ClaimsDetail.tpaIdOfClient AS TPA_ID
      ,ClaimsDetail.tpaDivision AS TPA_DIV_ID
      ,'MC400Upm' AS DATA_SOURCE_NAME
      ,ClaimsDetail.CLAIMNBR AS CLAIM_NBR
      ,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
      ,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
      ,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
      ,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
      ,'Adjustment' AS REASON_TYPE_CODE
      ,2 AS CODE_POSITION
      ,TRIM(ClaimsDetail.AdjustmentReason2) AS REASON_CODE
      ,UTIL.FXN_ARRAY_HASH([REASON_CODE]) AS HASH_DIFF
      FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
        JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
            ON (claims.tpaClient = claimsDetail.tpaClient
            AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
            AND claims.tpaDivision = claimsDetail.tpaDivision
            AND claims.claimNbr = claimsDetail.claimNbr)
      WHERE AdjustmentReason2 <> ''
      AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
  ) ADJUSTMENT_REASONS
;