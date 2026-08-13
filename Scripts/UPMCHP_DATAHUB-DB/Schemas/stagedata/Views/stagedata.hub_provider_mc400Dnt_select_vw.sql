!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.HUB_PROVIDER_MC400DNT_SELECT_VW
COMMENT = 'This is a HUB View containing Provider data'
AS
SELECT
ProvidersSeqNbr AS SOURCE_KEY
,'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,ProviderNbr AS PROVIDER_ID
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, PROVIDER_ID]) AS HUB_PROVIDER_HKEY
FROM &{MC400}.DWDNV.PROVIDERS
WHERE UPPER(SUBSTR(ProviderNbr,1,1)) <> 'V' --MC400 Business logic for medical groups
AND UPPER(SUBSTR(PrimarySpecialty,1,4)) NOT IN ('INST-TAXID','INST-DEFAU')
;

!set variable_substitution=false;

/*
HUB_PROVIDER AND HUB_MEDICAL_GROUP need revisted and probably merged into one table, hub_provider with respective sat tables.
refferring providers and be providers or medical groups.  building the linkage (lnk) tables does not really work when they are different hubs


 */