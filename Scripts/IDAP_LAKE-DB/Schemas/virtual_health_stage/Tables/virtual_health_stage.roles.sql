CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ROLES
(
ID                            INT,
NAME                      VARCHAR,
TAGS_BITMAP                   INT,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
LOCKED                        INT,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
