!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.SAT_PROVIDER_DETAIL_MC400DNT_SELECT_VW
COMMENT = 'This is a SAT View containing Provider Detail data'
AS
SELECT 
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,Providers.ProviderNbr AS PROVIDER_ID
,CASE 
    WHEN (SUBSTRING(TRIM(Providers.PrimarySpecialty),1,4) = 'SPEC')
        THEN 'Practitioner'
    WHEN (SUBSTRING(TRIM(Providers.PrimarySpecialty),1,4) = 'INST')
        THEN 'Facility'
    ELSE NULL
END AS PROVIDER_TYPE_NAME
,IFF(TRIM(Providers.ProviderName) = '', TRIM(Providers.Name), TRIM(Providers.ProviderName)) AS FULL_NAME
,IFF(TRIM(Providers.FirstName) = '', NULL, TRIM(Providers.FirstName)) AS FIRST_NAME
,IFF(TRIM(Providers.ProviderName) = '',
    IFF(TRIM(Providers.ProviderLastName) = '', SPLIT_PART(TRIM(Providers.Name), ' ', 1), TRIM(Providers.ProviderLastName))
    ,NULL
) AS LAST_NAME
,NULL AS MIDDLE_NAME
,IFF(TRIM(Providers.ProviderName) = '', 
    IFF(TRIM(Providers.MINAME) = '', NULL, TRIM(Providers.MINAME))
    ,NULL
) AS MIDDLE_INITIAL_NAME
,CASE PROVIDER_TYPE_NAME
    WHEN 'Practitioner'
        THEN
        CASE UPPER(TRIM(Providers.Gender))
            WHEN 'F'
                THEN 'Female'
            WHEN 'M'
                THEN 'Male'
            ELSE 'Unknown'
        END
    ELSE
        'n/a'
END AS GENDER_NAME
,IFF(TRIM(Providers.EmailAddress) = '', NULL, TRIM(Providers.EmailAddress)) AS EMAIL_ADDRESS
,IFF(TRIM(Providers.SSN) = '', NULL, TRIM(Providers.SSN)) AS SOCIAL_SECURITY_NBR
,IFF(TRIM(Providers.Degree) = '', NULL, TRIM(Providers.Degree)) AS DEGREE_TEXT
,IFF(TRIM(Providers.Title) = '', NULL, TRIM(Providers.Title)) AS SUFFIX_NAME
,NULL AS LOCUM_TENENS_IND
,NULL AS INVISIBLE_PROVIDER_IND
,NULL AS TEMPORARY_PROVIDER_IND
,IFF(TRIM(Providers.NationalProviderNbr) = '', NULL, TRIM(Providers.NationalProviderNbr)) AS NATIONAL_PROVIDER_ID
,TRY_TO_DATE(TO_VARCHAR(Providers.DateOfBirth), 'YYYYMMDD') AS DATE_OF_BIRTH
,IFF(TRIM(Providers.PrimaryPrefDeliveryMethod) = '', NULL, TRIM(Providers.PrimaryPrefDeliveryMethod)) AS PRIMARY_PREFERRED_DELIVERY_METHOD_CODE
,IFF(TRIM(Providers.BoardCertified) = '', NULL, TRIM(Providers.BoardCertified)) AS BOARD_CERTIFIED_IND
,IFF(TRIM(Providers.StateMedicaidId) = '', NULL, TRIM(Providers.StateMedicaidId)) AS STATE_MEDICAID_ID
,IFF(TRIM(Providers.PrimarySpecialty) = '', NULL, TRIM(Providers.PrimarySpecialty)) AS PRIMARY_SPECIALTY_NAME
,NULL AS PRIMARY_TAXONOMY_CODE
,NULL AS PRESCRIBER_SOURCE_CODE
,NULL AS UPIN_NBR
,NULL AS PROVIDER_START_DATE
,NULL AS PROVIDER_ACTIVE_IND
,NULL AS FACILITY_INCEPTION_DATE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, PROVIDER_ID]) AS HUB_PROVIDER_HKEY
,UTIL.FXN_ARRAY_HASH([
    PROVIDER_TYPE_NAME,
    FULL_NAME,
    FIRST_NAME,
    LAST_NAME,
    MIDDLE_NAME,
    MIDDLE_INITIAL_NAME,
    GENDER_NAME,
    EMAIL_ADDRESS,
    SOCIAL_SECURITY_NBR,
    DEGREE_TEXT,
    SUFFIX_NAME,
    LOCUM_TENENS_IND,
    INVISIBLE_PROVIDER_IND,
    TEMPORARY_PROVIDER_IND,
    NATIONAL_PROVIDER_ID,
    DATE_OF_BIRTH,
    PRIMARY_PREFERRED_DELIVERY_METHOD_CODE,
    BOARD_CERTIFIED_IND,
    STATE_MEDICAID_ID,
    PRIMARY_SPECIALTY_NAME,
    PRIMARY_TAXONOMY_CODE,
    PRESCRIBER_SOURCE_CODE,
    UPIN_NBR, 
    PROVIDER_START_DATE, 
    PROVIDER_ACTIVE_IND, 
    FACILITY_INCEPTION_DATE
]) AS HASH_DIFF
FROM  &{MC400}.DWDNV.Providers

WHERE UPPER(SUBSTR(Providers.ProviderNbr,1,1)) <> 'V' --MC400 Business logic for medical groups
AND UPPER(TRIM(Providers.PrimarySpecialty)) NOT IN ('INST-TAXID','INST-DEFAU')
;

!set variable_substitution=false;
