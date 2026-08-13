CREATE OR REPLACE VIEW STAGEDATA.LNK_CLAIM_REFERRING_PROVIDER_MC400UPM_SELECT_VW
COMMENT = 'Link between hub_claim_detail and hub_provider for the Referring Provider'
AS
SELECT
claims.tpaClient AS C_TPA_CLIENT_ID
,claims.tpaIdOfClient AS C_TPA_ID
,claims.tpaDivision AS C_TPA_DIV_ID
,'MC400Upm' AS C_DATA_SOURCE_NAME
,claims.claimNbr AS C_CLAIM_NBR
,claims.tpaClient AS P_TPA_CLIENT_ID
,claims.tpaIdOfClient AS P_TPA_ID
,claims.tpaDivision AS P_TPA_DIV_ID
,'MC400Upm' AS P_DATA_SOURCE_NAME
,claims.ReferringProvider AS P_PROVIDER_ID
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS LNK_CLAIM_REFERRING_PROVIDER_HKEY
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY
,UTIL.FXN_ARRAY_HASH([P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS HUB_PROVIDER_HKEY

from rawdata.mc400_dwoao_claims claims
    join rawdata.mc400_dwoao_providers providers
        on (providers.tpaClient = claims.tpaClient
        and providers.tpaIdOfClient = claims.tpaIdOfClient
        and providers.tpaDivision = claims.tpaDivision
        and providers.providerNbr = claims.referringProvider)
where claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
and trim(claims.referringProvider) <> '' --Do not build links unless there is a value
and upper(substr(claims.referringProvider, 1, 1)) <> 'V' --excluding anything that is a medical group.
;

/*
HUB_PROVIDER AND HUB_MEDICAL_GROUP need revisted and probably merged into one table, hub_provider with respective sat tables.
refferring providers can be providers or medical groups??.  building the linkage (lnk) tables does not really work when they are different hubs

this logic excludes referring providers that are facilites or medical groups
        AND UPPER(SUBSTR(PROVIDERS.ProviderNbr,1,1)) <> 'V' --MC400 Business logic for medical groups
        AND UPPER(SUBSTR(PROVIDERS.PrimarySpecialty,1,4)) NOT IN ('INST-TAXID','INST-DEFAU'))

 */
