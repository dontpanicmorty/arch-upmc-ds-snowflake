CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.TERMINATION_REASON
(
ID                      INT,
NAME                VARCHAR,
CODE                VARCHAR,
IS_LOCKED               INT,
IS_DELETED              INT,
LAST_UPDATED_BY         INT,
POSITION                INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
