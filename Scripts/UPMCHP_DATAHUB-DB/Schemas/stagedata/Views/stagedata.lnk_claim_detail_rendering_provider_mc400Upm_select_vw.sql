CREATE OR REPLACE VIEW STAGEDATA.LNK_CLAIM_DETAIL_RENDERING_PROVIDER_MC400UPM_SELECT_VW
COMMENT='Link between hub_claim_detail and hub_provider for the Rendering Provider'
AS
SELECT
claimsDetail.TpaClient AS CD_TPA_CLIENT_ID,  -- Specify table alias here
claimsDetail.TpaIdOfClient AS CD_TPA_ID,
claimsDetail.TpaDivision AS CD_TPA_DIV_ID,
'MC400Upm' AS CD_DATA_SOURCE_NAME,
claimsDetail.ClaimNbr AS CD_CLAIM_NBR,
STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(CD_DATA_SOURCE_NAME, claimsDetail.ProcedureModifier, claimsDetail.ProcedureCode, claimsDetail.SpecificDateOfService) AS CD_CLAIM_LINE_NBR,
claimsDetail.ClaimSequence AS CD_CLAIM_LINE_SEQ_NBR,
STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(CD_DATA_SOURCE_NAME, claimsDetail.ProcedureAdj) AS CD_CLAIM_LINE_PROCEDURE_ADJ_CODE,
claimsDetail.TpaClient AS P_TPA_CLIENT_ID,  -- Specify table alias here
claimsDetail.TpaIdOfClient AS P_TPA_ID,
claimsDetail.TpaDivision AS P_TPA_DIV_ID,
'MC400Upm' AS P_DATA_SOURCE_NAME,
IFF(claims.ClaimType = 'I', providers_FacilityPricingNbr.providerNbr, providers_ProviderNumberHCFA.providerNbr) AS P_PROVIDER_ID,
UTIL.FXN_ARRAY_HASH([CD_TPA_CLIENT_ID, CD_TPA_ID, CD_TPA_DIV_ID, CD_DATA_SOURCE_NAME, CD_CLAIM_NBR, CD_CLAIM_LINE_NBR, CD_CLAIM_LINE_SEQ_NBR, CD_CLAIM_LINE_PROCEDURE_ADJ_CODE, P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS LNK_CLAIM_DETAIL_RENDERING_PROVIDER_HKEY,
UTIL.FXN_ARRAY_HASH([CD_TPA_CLIENT_ID, CD_TPA_ID, CD_TPA_DIV_ID, CD_DATA_SOURCE_NAME, CD_CLAIM_NBR, CD_CLAIM_LINE_NBR, CD_CLAIM_LINE_SEQ_NBR, CD_CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY,
UTIL.FXN_ARRAY_HASH([P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS HUB_PROVIDER_HKEY

from rawdata.mc400_dwoao_claimsdetail claimsDetail
    join rawdata.mc400_dwoao_claims claims
        on (claims.tpaClient = claimsDetail.tpaClient
        and claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
        and claims.tpaDivision = claimsDetail.tpaDivision
        and claims.claimNbr = claimsDetail.claimNbr)

    left outer join rawdata.mc400_dwoao_providers providers_FacilityPricingNbr
        on (providers_FacilityPricingNbr.tpaClient = claims.tpaClient
        and providers_FacilityPricingNbr.tpaIdOfClient = claims.tpaIdOfClient
        and providers_FacilityPricingNbr.tpaDivision = claims.tpaDivision
        and providers_FacilityPricingNbr.providerNbr = claims.FacilityPricingNbr
        and substr(providers_FacilityPricingNbr.providerNbr,1,1) <> 'V') --excluding anything that is a medical group.  if medical groups are really valid here, we will need to reconfigure the data in the model

    left outer join rawdata.mc400_dwoao_providers providers_ProviderNumberHCFA
        on (providers_ProviderNumberHCFA.tpaClient = claimsDetail.tpaClient
        and providers_ProviderNumberHCFA.tpaIdOfClient = claimsDetail.tpaIdOfClient
        and providers_ProviderNumberHCFA.tpaDivision = claimsDetail.tpaDivision
        and providers_ProviderNumberHCFA.providerNbr = claimsDetail.ProviderNumberHCFA
        and substr(providers_ProviderNumberHCFA.providerNbr,1,1) <> 'V') --excluding anything that is a medical group.  if medical groups are really valid here, we will need to reconfigure the data in the model

where claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
and P_PROVIDER_ID is not null
;
