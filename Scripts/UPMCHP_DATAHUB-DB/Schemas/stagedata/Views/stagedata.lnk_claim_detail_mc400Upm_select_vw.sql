create or replace view STAGEDATA.LNK_CLAIM_DETAIL_MC400UPM_SELECT_VW
COMMENT='This is a LNK View containing Claim Detail data'
as 
select 
claimsDetail.TpaClient AS C_TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS C_TPA_ID
,claimsDetail.TpaDivision AS C_TPA_DIV_ID
,'MC400Upm'AS C_DATA_SOURCE_NAME
,claimsDetail.claimNbr AS C_CLAIM_NBR
,claimsDetail.TpaClient AS CD_TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS CD_TPA_ID
,claimsDetail.TpaDivision AS CD_TPA_DIV_ID
,'MC400Upm' AS CD_DATA_SOURCE_NAME
,claimsDetail.claimNbr AS CD_CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(CD_DATA_SOURCE_NAME, claimsDetail.ProcedureModifier, claimsDetail.ProcedureCode, claimsDetail.SpecificDateOfService) AS CD_CLAIM_LINE_NBR
,claimsDetail.claimSequence AS CD_CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(CD_DATA_SOURCE_NAME, claimsDetail.ProcedureAdj) AS CD_CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, CD_TPA_CLIENT_ID, CD_TPA_ID, CD_TPA_DIV_ID, CD_DATA_SOURCE_NAME, CD_CLAIM_NBR, CD_CLAIM_LINE_NBR, CD_CLAIM_LINE_SEQ_NBR, CD_CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS LNK_CLAIM_DETAIL_HKEY
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY
,UTIL.FXN_ARRAY_HASH([CD_TPA_CLIENT_ID, CD_TPA_ID, CD_TPA_DIV_ID, CD_DATA_SOURCE_NAME, CD_CLAIM_NBR, CD_CLAIM_LINE_NBR, CD_CLAIM_LINE_SEQ_NBR, CD_CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY

from rawdata.mc400_dwoao_claimsdetail claimsDetail
    join rawdata.mc400_dwoao_claims claims
        on (claims.tpaClient = claimsDetail.tpaClient
        and claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        and claims.tpaDivision = claimsDetail.tpaDivision
        and claims.claimNbr = claimsDetail.claimNbr)
where claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
;