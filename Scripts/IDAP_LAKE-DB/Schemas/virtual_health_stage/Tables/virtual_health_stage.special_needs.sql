CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SPECIAL_NEEDS
(
ID                            INT,
NAME                      VARCHAR,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
LOCKED                        INT,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT,
CODE                      VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
