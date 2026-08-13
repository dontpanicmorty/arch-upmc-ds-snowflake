CREATE OR REPLACE TABLE DHS.OIM_DETAIL_HISTORY(
    FILENAME                        VARCHAR,
    INSERT_DATETIME                 TIMESTAMP_NTZ,
    SSN                             VARCHAR,
    CATEGORY_CODE                   VARCHAR,
    STATUS_CODE                     VARCHAR,
    START_DATE                      VARCHAR,
    END_DATE                        VARCHAR,
    REDETERMINATION_DATE            VARCHAR
)
COMMENT = 'Historical data from Oracle'
;