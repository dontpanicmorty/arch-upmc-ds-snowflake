CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.EXTERNAL_DOC_IMPORT_FILE
(
ID                                INT,
AUTHOR_ID                         INT,
ORIGINAL_FILENAME             VARCHAR,
LAST_PROCESSED_LINE               INT,
FILE_OFFSET                       INT,
IN_PROGRESS                       INT,
ROWS_WITH_ERRORS                  INT,
ROWS_WITHOUT_ERRORS               INT,
STATUS                            INT,
PARSE_LOG_SUMMARY             VARCHAR,
CREATED_AT              TIMESTAMP_NTZ,
UPDATED_AT              TIMESTAMP_NTZ,
STORAGE_UUID                  VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
