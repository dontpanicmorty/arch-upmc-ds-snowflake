CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.HISTORICAL_DATA_FILE
(
ID                                   INT,
USER_ID                              INT,
TYPE                             VARCHAR,
FILENAME                         VARCHAR,
IN_PROGRESS                          INT,
IS_FAILED                            INT,
IS_FILE_FORMAT_INVALID               INT,
LAST_PROCESSED_LINE                  INT,
LAST_PROCESSED_SHEET                 INT,
FILE_OFFSET                          INT,
PARSE_LOG_SUMMARY                VARCHAR,
FIRST_START_DATE           TIMESTAMP_NTZ,
STARTS_COUNT                         INT,
CREATED_AT                 TIMESTAMP_NTZ,
UPDATED_AT                 TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
