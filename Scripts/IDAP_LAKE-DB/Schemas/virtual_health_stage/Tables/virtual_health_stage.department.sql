CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.DEPARTMENT
(
ID                            INT,
NAME                      VARCHAR,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
LOCKED                        INT,
HASH_ID                   VARCHAR,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
