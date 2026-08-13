CREATE OR REPLACE TABLE DHS.OIM_HEADER_HISTORY(
    FILENAME                        VARCHAR,
    INSERT_DATETIME                 TIMESTAMP_NTZ,
    SSN                             VARCHAR,
    LAST_NAME                       VARCHAR,
    FIRST_NAME                      VARCHAR,
    MIDDLE_NAME                     VARCHAR,
    DOB                             VARCHAR
)
COMMENT = 'Historical data from Oracle'
;