CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.COHORT
(
ID                      INT,
NAME                VARCHAR,
RANKING                 INT,
LOCKED                  INT,
SYSTEM_ID           VARCHAR,
IS_DELETED              INT,
LAST_UPDATED_BY         INT,
POSITION                INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
