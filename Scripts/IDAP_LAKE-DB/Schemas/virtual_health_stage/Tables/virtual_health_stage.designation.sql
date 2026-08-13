CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.DESIGNATION
(
ID                            INT,
NAME                      VARCHAR,
LOCKED                        INT,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
