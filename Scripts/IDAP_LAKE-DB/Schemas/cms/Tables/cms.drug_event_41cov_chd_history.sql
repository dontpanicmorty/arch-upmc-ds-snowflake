CREATE OR REPLACE TABLE CMS.DRUG_EVENT_41COV_CHD_HISTORY (
    RECORD_ID                           VARCHAR,
    SEQUENCE_NUMBER                     NUMBER,
    CONTRACT_NUMBER                     VARCHAR,
    FILE_ID                             VARCHAR,
    PROD_TEST_IND                       VARCHAR,
    AS_OF_YEAR                          VARCHAR,
    AS_OF_MONTH                         VARCHAR,
    DDPS_SYSTEM_DATE                    DATE,
    DDPS_SYSTEM_TIME                    VARCHAR,
    DDPS_REPORT_ID                      VARCHAR,
    FILLER                              VARCHAR,
    FILENAME                            VARCHAR,
    INSERT_DATETIME                     TIMESTAMP_NTZ
)
COMMENT = 'Historical data from Oracle through the end of 2025' 
;