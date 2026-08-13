CREATE OR REPLACE VIEW STAGEDATA.HUB_CLAIM_DETAIL_MC400UPM_SELECT_VW
	COMMENT='This is a HUB View containing Claim Detail data'
AS
 
SELECT 
ClaimsDetail.RowId AS SOURCE_KEY
,ClaimsDetail.TpaClient AS TPA_CLIENT_ID
,ClaimsDetail.TpaIdOfClient AS TPA_ID
,ClaimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ClaimsDetail.ClaimNbr AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY

FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
	JOIN RAWDATA.MC400_DWOAO_CLAIMS Claims
		ON (Claims.TpaClient = ClaimsDetail.TpaClient
		AND Claims.TpaIdOfClient = ClaimsDetail.TpaIdOfClient
		AND Claims.TpaDivision = ClaimsDetail.TpaDivision
		AND Claims.ClaimNbr = ClaimsDetail.ClaimNbr)
WHERE Claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
;