CREATE OR REPLACE TABLE REFDATA.SOURCE_DATA_MAPPING
(
    SOURCE_DATA_MAPPING_HKEY VARCHAR(32) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    DATA_DOMAIN_NAME VARCHAR NOT NULL COMMENT 'Domain for which the mapping applies (claims, member, provider, etc)',
    REFERENCE_SET_NAME VARCHAR NOT NULL COMMENT 'Scope of the code type(s) being mapping (CLAIM_PROCESSING_REASON, CLAIM_LOCATION, GENDER) this will be name of the REFDATA table',
    TPA_CLIENT_ID VARCHAR NOT NULL,
    TPA_ID VARCHAR NOT NULL,
    TPA_DIV_ID VARCHAR NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL COMMENT 'Standardized inbound source name of the data being mapped (skygen, nva, mc400upm)',
    SOURCE_VALUE VARCHAR NOT NULL COMMENT 'Source value from the inbound data set that is being mapped',
    SOURCE_VERSION_NBR NUMBER(38,0) NOT NULL,
    TARGET_VALUE VARCHAR NOT NULL COMMENT 'The target value applied for the inbound source_value',
    EFFECTIVE_START_DATE DATE NOT NULL COMMENT 'Start date of when row mapping is effective',
    EFFECTIVE_END_DATE DATE COMMENT 'End date of when row mapping is no longer effective',
    DATA_STEWARD_NAME VARCHAR NOT NULL COMMENT 'Name of person or business unit responsible for maintain mapping',
    CONSTRAINT PK_SOURCE_DATA_MAPPING PRIMARY KEY (SOURCE_DATA_MAPPING_HKEY),
    CONSTRAINT UK_SOURCE_DATA_MAPPING UNIQUE (DATA_DOMAIN_NAME, REFERENCE_SET_NAME, TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, SOURCE_VALUE, SOURCE_VERSION_NBR)
)
COMMENT = 'Source data mapping record for enterpise code mapping for inbound data to upmchp_datahub'
;