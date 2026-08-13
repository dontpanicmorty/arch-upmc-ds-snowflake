CREATE OR REPLACE TABLE EDW_RPT.VISION_PROVIDER
(
VISION_PROVIDER_KEY                    NUMBER,
VISION_PROVIDER_ID                    VARCHAR,
LOB                                   VARCHAR,
LOAD_DATE                       TIMESTAMP_NTZ,
UPDATE_DATE                     TIMESTAMP_NTZ,
VISION_PROVIDER_NAME                  VARCHAR,
ADDRESS_LINE_PRIMARY                  VARCHAR,
ADDRESS_LINE_SECONDARY                VARCHAR,
ADDRESS_CITY                          VARCHAR,
ADDRESS_STATE                         VARCHAR,
ADDRESS_ZIP_CODE                      VARCHAR,
TELEPHONE_NBR                         VARCHAR,
MEDICAID_ID                           VARCHAR,
TAX_ID_NBR                            VARCHAR,
VISION_PROVIDER_LOCATION_ID           VARCHAR,
PROVIDER_IND                          VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
