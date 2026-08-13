
CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_PROCEDURE_MODIFIER_MC400UPM_SELECT_VW
COMMENT = 'List of procedure modifers for MC400Upm.'
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
,TRIM(ClaimsDetail.ProcedureModifier) AS MODIFIER_CODE
,1 AS CODE_POSITION
,UTIL.FXN_ARRAY_HASH([NULL]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE ClaimsDetail.ProcedureModifier <> ''
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
,TRIM(ClaimsDetail.MODIFIER2) AS MODIFIER_CODE
,2 AS CODE_POSITION
,UTIL.FXN_ARRAY_HASH([NULL]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE ClaimsDetail.Modifier2 <> ''
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
,TRIM(ClaimsDetail.MODIFIER3) AS MODIFIER_CODE
,3 AS CODE_POSITION
,UTIL.FXN_ARRAY_HASH([NULL]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE ClaimsDetail.Modifier3 <> ''
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
,TRIM(ClaimsDetail.MODIFIER4) AS MODIFIER_CODE
,4 AS CODE_POSITION
,UTIL.FXN_ARRAY_HASH([NULL]) AS HASH_DIFF
FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.tpaClient = claimsDetail.tpaClient
        AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        AND claims.tpaDivision = claimsDetail.tpaDivision
        AND claims.claimNbr = claimsDetail.claimNbr)
WHERE ClaimsDetail.Modifier4 <> ''
AND claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
;