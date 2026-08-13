!set variable_substitution=true;

CREATE OR REPLACE VIEW RAWDATA.DWSKYGEN_PROVIDER_OFFICE_SELECT_VW
COMMENT = 'Pulls from SkygenDW to return 1 row per provider office with a concatenated ID to ensure uniqueness across provider types'
AS
SELECT 
    '000001' AS TPA_CLIENT_ID,
    '000001' AS TPA_ID,
    '0002' AS TPA_DIV_ID,
    CONCAT('LOCATION_', LOCATION_ID) AS OFFICE_ID,
    NULLIF(LocationName,'') AS OFFICE_NAME,
    NULLIF(LocationAddressLine1,'') AS ADDRESS_LINE_1,
    NULLIF(LocationAddressLine2,'') AS ADDRESS_LINE_2,
    NULLIF(LocationCity,'') AS CITY_NAME,
    NULLIF(LocationZip,'') AS ZIP_5,
    CASE 
        WHEN LocationZip4 = '0000' THEN NULL 
        ELSE NULLIF(LocationZip4,'')
    END AS ZIP_4,
    NULLIF(LocationState,'') AS STATE_ABBREV_NAME,
    NULLIF(LocationCountyDescription,'') AS COUNTY_NAME,
    NULLIF(LocationVoicePhone,'') AS OFFICE_PHONE_NBR,
    NULLIF(LocationFaxNumber,'') AS OFFICE_FAX_NBR,
    NULLIF(LocationEmail,'') as OFFICE_EMAIL,
    SpecialNeedsPatientFlag AS SPECIAL_NEEDS_PATIENT_FLAG,
    HandicapAccessFlag AS HANDICAP_ACCESS_FLAG
FROM &{DWSKYGEN}.DBO.DimLocation_VW
    WHERE RecordIsCurrent = 1
    AND LocationKey > 0
UNION ALL
SELECT 
    '000001' AS TPA_CLIENT_ID,
    '000001' AS TPA_ID,
    '0001' AS TPA_DIV_ID,
    CONCAT('LOCATION_', LOCATION_ID) AS OFFICE_ID,
    NULLIF(LocationName,'') AS OFFICE_NAME,
    NULLIF(LocationAddressLine1,'') AS ADDRESS_LINE_1,
    NULLIF(LocationAddressLine2,'') AS ADDRESS_LINE_2,
    NULLIF(LocationCity,'') AS CITY_NAME,
    NULLIF(LocationZip,'') AS ZIP_5,
    CASE 
        WHEN LocationZip4 = '0000' THEN NULL 
        ELSE NULLIF(LocationZip4,'')
    END AS ZIP_4,
    NULLIF(LocationState,'') AS STATE_ABBREV_NAME,
    NULLIF(LocationCountyDescription,'') AS COUNTY_NAME,
    NULLIF(LocationVoicePhone,'') AS OFFICE_PHONE_NBR,
    NULLIF(LocationFaxNumber,'') AS OFFICE_FAX_NBR,
    NULLIF(LocationEmail,'') as OFFICE_EMAIL,
    SpecialNeedsPatientFlag AS SPECIAL_NEEDS_PATIENT_FLAG,
    HandicapAccessFlag AS HANDICAP_ACCESS_FLAG
FROM &{DWSKYGEN}.DBO.DimLocation_VW
    WHERE RecordIsCurrent = 1
    AND LocationKey > 0    
;

!set variable_substitution=false;