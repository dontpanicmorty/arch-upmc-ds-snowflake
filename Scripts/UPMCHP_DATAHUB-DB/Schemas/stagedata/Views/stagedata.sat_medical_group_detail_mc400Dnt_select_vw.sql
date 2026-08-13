!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.SAT_MEDICAL_GROUP_DETAIL_MC400DNT_SELECT_VW
COMMENT = 'This is a SAT View containing Medical Group Details'
AS
SELECT
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,Providers.ProviderNbr AS MEDICAL_GROUP_ID
,IFNULL(Providers.ProviderName, Providers.Name) AS MEDICAL_GROUP_NAME
,IFF(TRIM(IFNULL(Providers.AlternateProviderNo,'')) = '', NULL, TRIM(Providers.AlternateProviderNo)) AS TAX_ID_NBR --yes, AlternateProviderNo is TIN
,IFF(TRIM(IFNULL(Providers.EmailAddress,'')) = '', NULL, TRIM(Providers.EmailAddress)) AS EMAIL_ADDRESS
,IFF(TRIM(IFNULL(Providers.NationalProviderNbr,'')) = '', NULL, TRIM(Providers.NationalProviderNbr)) AS NPI_NBR
,NULL AS MEDICAL_GROUP_START_DATE
,NULL AS MEDICAL_GROUP_ACTIVE_IND
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, MEDICAL_GROUP_ID]) AS HUB_MEDICAL_GROUP_HKEY
,UTIL.FXN_ARRAY_HASH(
    [
    MEDICAL_GROUP_NAME
    ,TAX_ID_NBR
    ,EMAIL_ADDRESS
    ,NPI_NBR
    ,MEDICAL_GROUP_START_DATE
    ,MEDICAL_GROUP_ACTIVE_IND
    ]
) AS HASH_DIFF

FROM &{MC400}.DWDNV.PROVIDERS
WHERE UPPER(SUBSTR(Providers.ProviderNbr,1,1)) = 'V' --MC400 Business logic for medical groups
;

!set variable_substitution=false;
