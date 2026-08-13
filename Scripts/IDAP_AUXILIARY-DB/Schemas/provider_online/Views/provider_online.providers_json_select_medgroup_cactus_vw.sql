CREATE OR REPLACE VIEW PROVIDER_ONLINE.PROVIDERS_JSON_SELECT_MEDGROUP_CACTUS_VW (
    ID, 
    NETWORK_ID, 
    PROVIDER_KEY, 
    PROVDIRJSONTXT
) COMMENT = 'Assembles the JSON structures required by provideronline providers collection' 
AS
WITH
    LEGALFIELDS AS ( --providerAddresses.legalFields 
        SELECT
            LEGAL_ADDRESS_RELATIONSHIP_KEY,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT(
                    'legalOfficeName',
                    TRIM(LEGAL_OFFICE_NAME),
                    'legalAddress1',
                    TRIM(LEGAL_ADDRESS1),
                    'legalAddress2',
                    TRIM(LEGAL_ADDRESS2),
                    'legalCity',
                    TRIM(LEGAL_CITY),
                    'legalState',
                    TRIM(LEGAL_STATE),
                    'legalZip',
                    TRIM(LEGAL_ZIP)
                )
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT(
                        'legalOfficeName',
                        TRIM(LEGAL_OFFICE_NAME),
                        'legalAddress1',
                        TRIM(LEGAL_ADDRESS1),
                        'legalAddress2',
                        TRIM(LEGAL_ADDRESS2),
                        'legalCity',
                        TRIM(LEGAL_CITY),
                        'legalState',
                        TRIM(LEGAL_STATE),
                        'legalZip',
                        TRIM(LEGAL_ZIP)
                    )
            ) AS LEGALFIELDSJSON
        FROM
            PROVIDER_ONLINE.LEGAL_ADDRESS_RELATIONSHIP
        GROUP BY
            LEGAL_ADDRESS_RELATIONSHIP_KEY
    ),
    SERVICEAREAS AS ( --providerAddresses.serviceAreas array construction
        SELECT
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            OFFICE_ID,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT('area', SERVICE_AREA_COUNTY_NAME, 'state', SERVICE_AREA_STATE_ABBREVIATION_NAME)
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT('area', SERVICE_AREA_COUNTY_NAME, 'state', SERVICE_AREA_STATE_ABBREVIATION_NAME)
            ) AS SERVICEAREASJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT
        WHERE
            SERVICE_AREA_COUNTY_NAME IS NOT NULL
        GROUP BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            OFFICE_ID
        ORDER BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            OFFICE_ID,
            SERVICEAREASJSON
    ),
    OFFICELANGUAGES AS ( --providerAddresses.officeLanguages array construction
        SELECT
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            OFFICE_ID,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT(
                    'officeLanguageName',
                    OFFICE_LANGUAGE_NAME,
                    'officeLanguageSupportServices',
                    OFFICE_LANGUAGE_SUPPORT_SERVICE
                )
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT(
                        'officeLanguageName',
                        OFFICE_LANGUAGE_NAME,
                        'officeLanguageSupportServices',
                        OFFICE_LANGUAGE_SUPPORT_SERVICE
                    )
            ) AS OFFICELANGUAGESJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT
        WHERE
            OFFICE_LANGUAGE_NAME IS NOT NULL
        GROUP BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            OFFICE_ID
        ORDER BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            OFFICE_ID,
            OFFICELANGUAGESJSON
    ),
    COORDINATES AS ( --providerAddresses.address.location.coordinates array construction
        SELECT
            ID,
            OFFICE_ID,
            ZIP_CODE_NUMBER,
            IFF(LENGTH(TRIM(COORDINATES)) < 2, NULL, COORDINATES) AS COORDINATES,
            IFF(LENGTH(TRIM(COORDINATES)) < 2, NULL, [SPLIT_PART(coordinates, ',', 1)::number(18,9), SPLIT_PART (coordinates, ',', 2)::number(18,9)]) AS COORDINATESJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT
        GROUP BY
            ID,
            OFFICE_ID,
            ZIP_CODE_NUMBER,
            COORDINATES
        ORDER BY
            ID,
            OFFICE_ID,
            ZIP_CODE_NUMBER,
            COORDINATES,
            COORDINATESJSON
    ),
    LOCATION AS ( --providerAddresses.address.location array construction
        SELECT
            PROVIDERDIRECTORY.ID,
            PROVIDERDIRECTORY.OFFICE_ID,
            PROVIDERDIRECTORY.ZIP_CODE_NUMBER,
            PROVIDERDIRECTORY.COORDINATES,
            OBJECT_CONSTRUCT('type', COORDINATE_TYPE, 'coordinates', C.COORDINATESJSON) AS LOCATIONJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT AS PROVIDERDIRECTORY
            LEFT JOIN COORDINATES C ON C.ID = PROVIDERDIRECTORY.ID
            AND C.OFFICE_ID = PROVIDERDIRECTORY.OFFICE_ID
            AND PROVIDERDIRECTORY.ZIP_CODE_NUMBER = C.ZIP_CODE_NUMBER
            AND C.COORDINATES = PROVIDERDIRECTORY.COORDINATES
        GROUP BY
            PROVIDERDIRECTORY.ID,
            PROVIDERDIRECTORY.OFFICE_ID,
            PROVIDERDIRECTORY.ZIP_CODE_NUMBER,
            PROVIDERDIRECTORY.COORDINATES,
            COORDINATE_TYPE,
            C.COORDINATESJSON
        ORDER BY
            PROVIDERDIRECTORY.ID,
            PROVIDERDIRECTORY.OFFICE_ID,
            PROVIDERDIRECTORY.ZIP_CODE_NUMBER,
            COORDINATE_TYPE,
            C.COORDINATESJSON
    ),
    ADDRESS AS ( --providerAddresses.address array construction
        SELECT DISTINCT
            PROVIDERDIRECTORY.ID,
            NETWORK_ID,
            PROVIDER_KEY,
            PROVIDERDIRECTORY.OFFICE_ID,
            ADDRESSLINE1_TEXT,
            OBJECT_CONSTRUCT(
                'addressLine1',
                ADDRESSLINE1_TEXT,
                'addressLine2',
                ADDRESSLINE2_TEXT,
                'city',
                CITY_NAME,
                'stateAbbreviation',
                STATE_ABBREVIATION_NAME,
                'countryName',
                COUNTRY_NAME,
                'zipCode',
                PROVIDERDIRECTORY.ZIP_CODE_NUMBER,
                'countyName',
                COUNTY_NAME,
                'location',
                LOCATIONJSON
            ) AS ADDRESSJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT AS PROVIDERDIRECTORY
            LEFT JOIN LOCATION ON LOCATION.ID = PROVIDERDIRECTORY.ID
            AND LOCATION.OFFICE_ID = PROVIDERDIRECTORY.OFFICE_ID
            AND PROVIDERDIRECTORY.ZIP_CODE_NUMBER = LOCATION.ZIP_CODE_NUMBER
            AND PROVIDERDIRECTORY.COORDINATES = LOCATION.COORDINATES
        GROUP BY
            PROVIDERDIRECTORY.ID,
            NETWORK_ID,
            PROVIDER_KEY,
            PROVIDERDIRECTORY.OFFICE_ID,
            PROVIDERDIRECTORY.OFFICE_ID,
            ADDRESSLINE1_TEXT,
            ADDRESSLINE2_TEXT,
            CITY_NAME,
            STATE_ABBREVIATION_NAME,
            COUNTRY_NAME,
            PROVIDERDIRECTORY.ZIP_CODE_NUMBER,
            COUNTY_NAME,
            LOCATIONJSON
    ),
    PROVIDERADDRESS AS ( --providerAddresses array construction
        SELECT
            PROVIDER_DIRECTORY.ID,
            PROVIDER_DIRECTORY.NETWORK_ID,
            PROVIDER_DIRECTORY.PROVIDER_KEY,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT(
                    'officeId',
                    PROVIDER_DIRECTORY.OFFICE_ID,
                    'dataSource',
                    DATA_SOURCE_NAME,
                    'officeName',
                    OFFICE_NAME,
                    'primaryPhoneNumber',
                    PRIMARY_PHONE_NUMBER,
                    'faxNumber',
                    FAX_NUMBER,
                    'handicapAccessIndicator',
                    HANDICAP_ACCESS_INDICATOR,
                    'teleHealthIndicator',
                    TELE_HEALTH_INDICATOR,
                    'virtualCareModelIndicator',
                    VIRTUAL_CARE_MODEL_INDICATOR,
                    'maSuperPCPInd',
                    MASUPER_PCP_INDICATOR,
                    'upmcOwnedLocationIndicator',
                    UPMC_OWNED_LOCATION_INDICATOR,
                    'taxIdentificationNumber',
                    TAX_ID_NUMBER,
                    'vCode',
                    VCODE,
                    'facilityType',
                    FACILITY_TYPE,
                    'weekendScheduleHoursIndicator',
                    WEEKEND_SCHEDULE_HOURS_INDICATOR,
                    'eveningScheduleHoursIndicator',
                    EVENING_SCHEDULE_HOURS_INDICATOR,
                    'officeLanguages',
                    OFFICELANGUAGESJSON,
                    'serviceareas',
                    SERVICEAREAS.SERVICEAREASJSON,
                    'address',
                    ADDRESS.ADDRESSJSON,
                    'officeNameSearch',
                    UPPER(REGEXP_REPLACE(OFFICE_NAME, '([^$a-zA-Z0-9])', '')),
                    'billingProviderClaimTypeCode',
                    PROVIDER_DIRECTORY.BILLING_PROVIDER_CLAIM_TYPE
                )
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT(
                        'officeId',
                        PROVIDER_DIRECTORY.OFFICE_ID,
                        'dataSource',
                        DATA_SOURCE_NAME,
                        'officeName',
                        OFFICE_NAME,
                        'primaryPhoneNumber',
                        PRIMARY_PHONE_NUMBER,
                        'faxNumber',
                        FAX_NUMBER,
                        'handicapAccessIndicator',
                        HANDICAP_ACCESS_INDICATOR,
                        'teleHealthIndicator',
                        TELE_HEALTH_INDICATOR,
                        'virtualCareModelIndicator',
                        VIRTUAL_CARE_MODEL_INDICATOR,
                        'maSuperPCPInd',
                        MASUPER_PCP_INDICATOR,
                        'upmcOwnedLocationIndicator',
                        UPMC_OWNED_LOCATION_INDICATOR,
                        'taxIdentificationNumber',
                        TAX_ID_NUMBER,
                        'vCode',
                        VCODE,
                        'facilityType',
                        FACILITY_TYPE,
                        'weekendScheduleHoursIndicator',
                        WEEKEND_SCHEDULE_HOURS_INDICATOR,
                        'eveningScheduleHoursIndicator',
                        EVENING_SCHEDULE_HOURS_INDICATOR,
                        'officeLanguages',
                        OFFICELANGUAGESJSON,
                        'serviceareas',
                        SERVICEAREAS.SERVICEAREASJSON,
                        'address',
                        ADDRESS.ADDRESSJSON,
                        'officeNameSearch',
                        UPPER(REGEXP_REPLACE(OFFICE_NAME, '([^$a-zA-Z0-9])', '')),
                        'billingProviderClaimTypeCode',
                        PROVIDER_DIRECTORY.BILLING_PROVIDER_CLAIM_TYPE
                    )
            ) AS PROVIDERADDRESS
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT PROVIDER_DIRECTORY
            LEFT JOIN SERVICEAREAS ON SERVICEAREAS.ID = PROVIDER_DIRECTORY.ID
            AND SERVICEAREAS.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
            AND SERVICEAREAS.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
            AND SERVICEAREAS.OFFICE_ID = PROVIDER_DIRECTORY.OFFICE_ID
            LEFT JOIN OFFICELANGUAGES ON OFFICELANGUAGES.ID = PROVIDER_DIRECTORY.ID
            AND OFFICELANGUAGES.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
            AND OFFICELANGUAGES.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
            AND OFFICELANGUAGES.OFFICE_ID = PROVIDER_DIRECTORY.OFFICE_ID
            LEFT JOIN ADDRESS ON ADDRESS.ID = PROVIDER_DIRECTORY.ID
            AND ADDRESS.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
            AND ADDRESS.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
            AND ADDRESS.OFFICE_ID = PROVIDER_DIRECTORY.OFFICE_ID
            AND ADDRESS.ADDRESSLINE1_TEXT = PROVIDER_DIRECTORY.ADDRESSLINE1_TEXT
        GROUP BY
            PROVIDER_DIRECTORY.ID,
            PROVIDER_DIRECTORY.NETWORK_ID,
            PROVIDER_DIRECTORY.PROVIDER_KEY
        ORDER BY
            PROVIDER_DIRECTORY.ID,
            PROVIDER_DIRECTORY.NETWORK_ID,
            PROVIDER_DIRECTORY.PROVIDER_KEY,
            PROVIDERADDRESS
    ),
    FACILITYCONTRACT AS ( --providerAffiliations.facilityContract array construction
        SELECT
            PROVIDER_KEY || PROVIDER_DIRECTORY_NETWORK_ID AS PROVIDERAFFILIATIONID,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT(
                    'facilitySubproductKey',
                    PROVIDER_DIRECTORY_H2_SUB_PRODUCT_KEY,
                    'facilityContractLevel',
                    CONTRACT_LEVEL_CODE,
                    'leveledSubproductInd',
                    LEVELED_SUB_PRODUCT_INDICATOR
                )
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT(
                        'facilitySubproductKey',
                        PROVIDER_DIRECTORY_H2_SUB_PRODUCT_KEY,
                        'facilityContractLevel',
                        CONTRACT_LEVEL_CODE,
                        'leveledSubproductInd',
                        LEVELED_SUB_PRODUCT_INDICATOR
                    )
            ) AS FACILITYCONTRACTJSON
        FROM
            PROVIDER_ONLINE.AFFILIATIONS_NON_PARTICIPANT
        GROUP BY
            PROVIDER_KEY || PROVIDER_DIRECTORY_NETWORK_ID
        ORDER BY
            PROVIDER_KEY || PROVIDER_DIRECTORY_NETWORK_ID,
            FACILITYCONTRACTJSON
    ),
    PROVIDERAFFILIATIONS AS ( --providerAffiliations array construction
        SELECT
            A.PROVIDER_KEY || A.PROVIDER_DIRECTORY_NETWORK_ID AS PROVIDERAFFILIATIONID,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT(
                    'providerAffiliationId',
                    A.PROVIDER_KEY || A.PROVIDER_DIRECTORY_NETWORK_ID,
                    'facilityName',
                    A.FACILITY_NAME,
                    'upmcHosp',
                    A.ADMIT_HOSP_OWNED_STATUS,
                    'facilityContract',
                    FACILITYCONTRACT.FACILITYCONTRACTJSON
                )
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT(
                        'providerAffiliationId',
                        A.PROVIDER_KEY || A.PROVIDER_DIRECTORY_NETWORK_ID,
                        'facilityName',
                        A.FACILITY_NAME,
                        'upmcHosp',
                        A.ADMIT_HOSP_OWNED_STATUS,
                        'facilityContract',
                        FACILITYCONTRACT.FACILITYCONTRACTJSON
                    )
            ) AS PROVIDERAFFILIATIONSJSON
        FROM
            PROVIDER_ONLINE.AFFILIATIONS_NON_PARTICIPANT A
            LEFT JOIN FACILITYCONTRACT ON A.PROVIDER_KEY || A.PROVIDER_DIRECTORY_NETWORK_ID = FACILITYCONTRACT.PROVIDERAFFILIATIONID
        GROUP BY
            A.PROVIDER_KEY || A.PROVIDER_DIRECTORY_NETWORK_ID
        ORDER BY
            A.PROVIDER_KEY || A.PROVIDER_DIRECTORY_NETWORK_ID,
            PROVIDERAFFILIATIONSJSON
    ),
    BOARDCERTIFICATION AS ( --boardCertifications array constructions
        SELECT
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            ARRAY_AGG(DISTINCT OBJECT_CONSTRUCT('boardCertificationName', BOARD_CERTIFICATION)) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT('boardCertificationName', BOARD_CERTIFICATION)
            ) AS BOARDCERTIFICATIONJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT
        WHERE
            BOARD_CERTIFICATION IS NOT NULL
        GROUP BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY
        ORDER BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            BOARDCERTIFICATIONJSON
    ),
    LANGUAGENAME AS ( --providerLanguages array construction
        SELECT
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            ARRAY_AGG(DISTINCT OBJECT_CONSTRUCT('languageName', LANGUAGE_NAME)) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT('languageName', LANGUAGE_NAME)
            ) AS LANGUAGENAMEJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT
        WHERE
            LANGUAGE_NAME IS NOT NULL
        GROUP BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY
        ORDER BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            LANGUAGENAMEJSON
    ),
    ACCREDITATIONS AS ( --accreditations array construction
        SELECT
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            ARRAY_AGG(
                DISTINCT OBJECT_CONSTRUCT(
                    'accreditationAgencyName',
                    ACCREDITATION_AGENCY_NAME,
                    'accreditationAgencyURL',
                    ACCREDITATION_AGENCY_URL,
                    'iconFileName',
                    ICON_FILE_TEXT,
                    'programDescription',
                    PROGRAM_DESCRIPTION,
                    'programLink',
                    PROGRAM_LINK_TEXT
                )
            ) WITHIN GROUP (
                ORDER BY
                    OBJECT_CONSTRUCT(
                        'accreditationAgencyName',
                        ACCREDITATION_AGENCY_NAME,
                        'accreditationAgencyURL',
                        ACCREDITATION_AGENCY_URL,
                        'iconFileName',
                        ICON_FILE_TEXT,
                        'programDescription',
                        PROGRAM_DESCRIPTION,
                        'programLink',
                        PROGRAM_LINK_TEXT
                    )
            ) AS ACCREDITATIONSJSON
        FROM
            PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT
        WHERE
            ACCREDITATION_AGENCY_NAME IS NOT NULL
        GROUP BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY
        ORDER BY
            ID,
            NETWORK_ID,
            PROVIDER_KEY,
            ACCREDITATIONSJSON
    )
    --Final JSON document construction
SELECT DISTINCT
    PROVIDER_DIRECTORY.ID,
    PROVIDER_DIRECTORY.CLIENT_ID || PROVIDER_DIRECTORY.TPA_ID || PROVIDER_DIRECTORY.TPA_DIV_ID || PROVIDER_DIRECTORY.NETWORK_ID AS NETWORK_ID,
    PROVIDER_DIRECTORY.PROVIDER_KEY,
    OBJECT_CONSTRUCT(
        'id',
        PROVIDER_DIRECTORY.ID,
        'providerKey',
        PROVIDER_DIRECTORY.PROVIDER_KEY,
        'networkId',
        PROVIDER_DIRECTORY.CLIENT_ID || PROVIDER_DIRECTORY.TPA_ID || PROVIDER_DIRECTORY.TPA_DIV_ID || PROVIDER_DIRECTORY.NETWORK_ID,
        'isLogicalDelete',
        0,
        'isOfficeUpdated',
        O.OFFICE_ID_CHANGE_INDICATOR,
        'sourceProviderNumber',
        PROVIDER_NUMBER,
        'emailAddress',
        EMAIL_ADDRESS_TEXT,
        'medicaidIndicator',
        MEDICAID_INDICATOR,
        'providerFullName',
        PROVIDER_FULL_NAME,
        'providerFirstName',
        PROVIDER_FIRST_NAME,
        'providerLastName',
        PROVIDER_LAST_NAME,
        'subType',
        PROVIDER_DIRECTORY.PROVIDER_SUB_TYPE_DESCRIPTION,
        'providerFullNameSearch',
        UPPER(REGEXP_REPLACE(PROVIDER_DIRECTORY.PROVIDER_FULL_NAME, '([^$a-zA-Z0-9])', '')),
        'gender',
        PRACTITIONER_GENDER_NAME,
        'providerNPI',
        PROVIDER_NPI,
        'subPartNPIs',
        IFF(PROVIDER_SUB_TYPE_DESCRIPTION IN ('Facility', 'Medical Group'), SPLIT(SUBPART_NPIS, ', '), NULL),
        'providerAddresses',
        PROVIDERADDRESS.PROVIDERADDRESS,
        'legalFields',
        LEGALFIELDSJSON,
        'boardCertifications',
        BOARDCERTIFICATION.BOARDCERTIFICATIONJSON,
        'providerLanguages',
        LANGUAGENAME.LANGUAGENAMEJSON,
        'accreditations',
        ACCREDITATIONS.ACCREDITATIONSJSON,
        'providerAffiliations',
        PROVIDERAFFILIATIONS.PROVIDERAFFILIATIONSJSON
    ) AS PROVDIRJSONTXT
FROM
    PROVIDER_ONLINE.DIRECTORY_NON_PARTICIPANT PROVIDER_DIRECTORY
    LEFT JOIN BOARDCERTIFICATION ON BOARDCERTIFICATION.ID = PROVIDER_DIRECTORY.ID
    AND BOARDCERTIFICATION.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
    AND BOARDCERTIFICATION.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
    LEFT JOIN LANGUAGENAME ON LANGUAGENAME.ID = PROVIDER_DIRECTORY.ID
    AND LANGUAGENAME.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
    AND LANGUAGENAME.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
    LEFT JOIN ACCREDITATIONS ON ACCREDITATIONS.ID = PROVIDER_DIRECTORY.ID
    AND ACCREDITATIONS.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
    AND ACCREDITATIONS.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
    LEFT JOIN PROVIDERADDRESS ON PROVIDERADDRESS.ID = PROVIDER_DIRECTORY.ID
    AND PROVIDERADDRESS.NETWORK_ID = PROVIDER_DIRECTORY.NETWORK_ID
    AND PROVIDERADDRESS.PROVIDER_KEY = PROVIDER_DIRECTORY.PROVIDER_KEY
    LEFT JOIN PROVIDERAFFILIATIONS ON (PROVIDER_DIRECTORY.PROVIDER_KEY || PROVIDER_DIRECTORY.NETWORK_ID) = PROVIDERAFFILIATIONS.PROVIDERAFFILIATIONID
    LEFT JOIN PROVIDER_ONLINE.OFFICE_LIST_NON_PARTICIPANT O ON O.ID = PROVIDER_DIRECTORY.ID
    LEFT JOIN LEGALFIELDS ON LEGALFIELDS.LEGAL_ADDRESS_RELATIONSHIP_KEY = PROVIDER_DIRECTORY.LEGAL_ADDRESS_RELATIONSHIP_KEY
WHERE
    PROVIDER_DIRECTORY.PROVIDER_SUB_TYPE_DESCRIPTION = 'Medical Group'
    AND PROVIDER_DIRECTORY.NETWORK_ID IS NOT NULL
    AND PROVIDER_DIRECTORY.DATA_SOURCE_NAME = 'Cactus'
GROUP BY
    PROVIDER_DIRECTORY.ID,
    PROVIDER_DIRECTORY.CLIENT_ID || PROVIDER_DIRECTORY.TPA_ID || PROVIDER_DIRECTORY.TPA_DIV_ID || PROVIDER_DIRECTORY.NETWORK_ID,
    PROVIDER_DIRECTORY.PROVIDER_KEY,
    PROVIDER_NUMBER,
    EMAIL_ADDRESS_TEXT,
    MEDICAID_INDICATOR,
    PROVIDER_FULL_NAME,
    PROVIDER_FIRST_NAME,
    PROVIDER_LAST_NAME,
    PROVIDER_NAME_PARTITION,
    PRACTITIONER_GENDER_NAME,
    PROVIDER_NPI,
    SUBPART_NPIS,
    PROVIDERADDRESS.PROVIDERADDRESS,
    LEGALFIELDS.LEGALFIELDSJSON,
    BOARDCERTIFICATION.BOARDCERTIFICATIONJSON,
    LANGUAGENAME.LANGUAGENAMEJSON,
    ACCREDITATIONS.ACCREDITATIONSJSON,
    PROVIDERAFFILIATIONS.PROVIDERAFFILIATIONSJSON,
    O.OFFICE_ID_CHANGE_INDICATOR,
    PROVIDER_DIRECTORY.PROVIDER_SUB_TYPE_DESCRIPTION;