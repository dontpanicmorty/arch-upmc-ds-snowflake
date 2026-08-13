!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_NOT_COVERED_REASON_MC400DNT_SELECT_VW
COMMENT = 'This is a SAT View containing Claim Line Not Covered Reason data'
AS
SELECT
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,ClaimsDetail.ClaimNbr AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,'Reason' AS NOT_COVERED_REASON_TYPE
,TRIM(ClaimsDetail.NotCoveredReason) AS NOT_COVERED_REASON_CODE
,UTIL.FXN_ARRAY_HASH([NULL]) AS HASH_DIFF
,UTIL.FXN_ARRAY_HASH(
            [TPA_CLIENT_ID
            ,TPA_ID
            ,TPA_DIV_ID
            ,DATA_SOURCE_NAME
            ,CLAIM_NBR
            ,CLAIM_LINE_NBR
            ,CLAIM_LINE_SEQ_NBR
            ,CLAIM_LINE_PROCEDURE_ADJ_CODE
            ]) AS HUB_CLAIM_DETAIL_HKEY

FROM &{MC400}.DWDNV.ClaimsDetail
WHERE IFNULL(ClaimsDetail.NotCoveredReason,'') <> ''
AND ClaimsDetail.ClaimNbr IN (SELECT ClaimNbr FROM &{MC400}.DWDNV.Claims WHERE MemberNbr <> '99999999901')
;

!set variable_substitution=false;