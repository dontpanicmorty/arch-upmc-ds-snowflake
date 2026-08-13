CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.AUTHORIZATION_FILE
(
ID                                INT,
FILE_TYPE                     VARCHAR,
FILENAME                      VARCHAR,
FILENAME_ORIGINAL             VARCHAR,
OWNER_ID                          INT,
IN_PROGRESS                       INT,
LAST_PROCESSED_LINE               INT,
LOG                           VARCHAR,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
FILE_SIZE                         INT,
FILE_OFFSET                       INT,
IS_FAILED                         INT,
PARSE_LOG_SUMMARY             VARCHAR,
FIRST_START_DATE        TIMESTAMP_NTZ,
STARTS_COUNT                      INT,
DATE_START              TIMESTAMP_NTZ,
DATE_END                TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;