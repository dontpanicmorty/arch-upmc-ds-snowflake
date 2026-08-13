CREATE OR REPLACE TABLE EDW_RPT.DENTAL_PROVIDER
(
DENTAL_PROVIDER_KEY                    NUMBER,
DENTAL_PROVIDER_NAME                  VARCHAR,
ADDRESS_LINE_PRIMARY                  VARCHAR,
ADDRESS_CITY                          VARCHAR,
ADDRESS_LINE_SECONDARY                VARCHAR,
ADDRESS_STATE                         VARCHAR,
ADDRESS_ZIP_CODE                      VARCHAR,
TELEPHONE_NBR                         VARCHAR,
DENTAL_PROVIDER_LOCATION_ID           VARCHAR,
DENTAL_PROVIDER_ID                    VARCHAR,
TAX_ID_NBR                            VARCHAR,
LOAD_DATE                       TIMESTAMP_NTZ,
UPDATE_DATE                     TIMESTAMP_NTZ,
MEDICAID_ID                           VARCHAR,
PROVIDER_IND                          VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
