CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.EXTERNAL_DOC_FILE_TYPE
(
ID                            INT,
NAME                      VARCHAR,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT,
IS_LOCKED                     INT,
VISIBLE_FOR_CP                INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
