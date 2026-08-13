CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.TASK_TEMPLATES
(
ID                            INT,
TYPE                      VARCHAR,
NAME                      VARCHAR,
LOCKED                        INT,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
