create or replace view STAGEDATA.LNK_CLAIM_BILLING_PROVIDER_MC400UPM_SELECT_VW
COMMENT='Link between hub_claim and hub_medical_group for the Billing Provider'
as
select
claims.TpaClient AS C_TPA_CLIENT_ID,
claims.TpaIdOfClient AS C_TPA_ID,
claims.TpaDivision AS C_TPA_DIV_ID,
'MC400Upm' AS C_DATA_SOURCE_NAME,
claims.claimNbr AS C_CLAIM_NBR,
claims.TpaClient AS MG_TPA_CLIENT_ID,
claims.TpaIdOfClient AS MG_TPA_ID,
claims.TpaDivision AS MG_TPA_DIV_ID,
'MC400Upm' AS MG_DATA_SOURCE_NAME,
claims.providerNbr AS MG_MEDICAL_GROUP_ID,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_MEDICAL_GROUP_ID]) AS LNK_CLAIM_BILLING_PROVIDER_HKEY,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY,
UTIL.FXN_ARRAY_HASH([MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_MEDICAL_GROUP_ID]) AS HUB_MEDICAL_GROUP_HKEY 
from rawdata.mc400_dwoao_claims claims
    join rawdata.mc400_dwoao_providers providers
        on (providers.tpaClient = claims.tpaClient
        and providers.tpaIdOfClient = claims.tpaIdOfClient
        and providers.tpaDivision = claims.tpaDivision
        and providers.providerNbr = claims.providerNbr)
where claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
and upper(substr(claims.providerNbr,1,1)) = 'V' --This might needs to looked into as to why there are billing providers on claims that do not start with V
;
