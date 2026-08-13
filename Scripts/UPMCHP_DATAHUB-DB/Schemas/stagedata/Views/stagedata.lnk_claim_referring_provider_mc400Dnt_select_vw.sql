!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.LNK_CLAIM_REFERRING_PROVIDER_MC400Dnt_SELECT_VW
COMMENT = 'Link between hub_claim_detail and hub_provider for the Referring Provider'
AS
SELECT
'000001' AS C_TPA_CLIENT_ID
,'000001' AS C_TPA_ID
,'0001' AS C_TPA_DIV_ID
,'MC400Dnt' AS C_DATA_SOURCE_NAME
,CLAIMS.CLAIMNBR AS C_CLAIM_NBR
,'000001' AS P_TPA_CLIENT_ID
,'000001' AS P_TPA_ID
,'0001' AS P_TPA_DIV_ID
,'MC400Dnt' AS P_DATA_SOURCE_NAME
,CLAIMS.ReferringProvider AS P_PROVIDER_ID
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS LNK_CLAIM_REFERRING_PROVIDER_HKEY
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY
,UTIL.FXN_ARRAY_HASH([P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PROVIDER_ID]) AS HUB_PROVIDER_HKEY
FROM &{MC400}.DWDNV.CLAIMS
    JOIN &{MC400}.DWDNV.PROVIDERS
        ON (PROVIDERS.ProviderNbr = CLAIMS.ReferringProvider
        AND UPPER(SUBSTR(PROVIDERS.ProviderNbr,1,1)) <> 'V' --MC400 Business logic for medical groups
        AND UPPER(SUBSTR(PROVIDERS.PrimarySpecialty,1,4)) NOT IN ('INST-TAXID','INST-DEFAU'))
WHERE CLAIMS.ReferringProvider IS NOT NULL 
AND IFNULL(CLAIMS.ReferringProvider,'') <> ''
AND CLAIMS.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
;
!set variable_substitution=false;

/*
HUB_PROVIDER AND HUB_MEDICAL_GROUP need revisted and probably merged into one table, hub_provider with respective sat tables.
refferring providers and be providers or medical groups.  building the linkage (lnk) tables does not really work when they are different hubs

this logic excludes referring providers that are facilites or medical groups
        AND UPPER(SUBSTR(PROVIDERS.ProviderNbr,1,1)) <> 'V' --MC400 Business logic for medical groups
        AND UPPER(SUBSTR(PROVIDERS.PrimarySpecialty,1,4)) NOT IN ('INST-TAXID','INST-DEFAU'))

 */