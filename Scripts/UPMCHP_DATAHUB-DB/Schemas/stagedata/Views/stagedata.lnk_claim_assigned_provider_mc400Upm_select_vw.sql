CREATE OR REPLACE VIEW STAGEDATA.LNK_CLAIM_ASSIGNED_PROVIDER_MC400UPM_SELECT_VW
COMMENT = 'Link between claim and provider for the Assigned Provider'
as
select
claims.TpaClient AS C_TPA_CLIENT_ID,
claims.TpaIdOfClient AS C_TPA_ID,
claims.TpaDivision AS C_TPA_DIV_ID,
'MC400Upm' AS C_DATA_SOURCE_NAME,
claims.claimNbr AS C_CLAIM_NBR,
claims.TpaClient AS P_TPA_CLIENT_ID,
claims.TpaIdOfClient AS P_TPA_ID,
claims.TpaDivision AS P_TPA_DIV_ID,
'MC400Upm' AS P_DATA_SOURCE_NAME,
trim(claims.assignedProvider1) AS P_PROVIDER_ID,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS LNK_CLAIM_ASSIGNED_PROVIDER_HKEY,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY,
UTIL.FXN_ARRAY_HASH([P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS HUB_PROVIDER_HKEY

from rawdata.mc400_dwoao_claims claims
    join rawdata.mc400_dwoao_providers providers
        on (providers.tpaClient = claims.tpaClient
        and providers.tpaIdOfClient = claims.tpaIdOfClient
        and providers.tpaDivision = claims.tpaDivision
        and providers.providerNbr = claims.assignedProvider1)

where claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
and trim(claims.assignedProvider1) <> '' --Do not build links unless there is a value
and upper(substr(claims.assignedProvider1,1,1)) <> 'V' --excluding anything that is a medical group.  if medical groups are really valid here, we will need to reconfigure the data in the model
;
