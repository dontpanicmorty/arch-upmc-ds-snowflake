CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.MEMBERSHIP_FILE
(
ID                                  INT,
AUTHOR_ID                           INT,
TYPE                            VARCHAR,
FILENAME                        VARCHAR,
FILENAME_ORIGINAL               VARCHAR,
FILENAME_PREPROCESSED           VARCHAR,
IN_PROGRESS                         INT,
CREATED_DATE              TIMESTAMP_NTZ,
LAST_PROCESSED_LINE                 INT,
FILE_OFFSET                         INT,
ROWS_WITH_ERRORS                    INT,
ROWS_WITHOUT_ERRORS                 INT,
DATA                            VARCHAR,
IS_FAILED                           INT,
PARSE_LOG_SUMMARY               VARCHAR,
UPDATED_DATE              TIMESTAMP_NTZ,
FIRST_START_DATE          TIMESTAMP_NTZ,
STARTS_COUNT                        INT,
REMOVED_FROM_QUEUE                  INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
