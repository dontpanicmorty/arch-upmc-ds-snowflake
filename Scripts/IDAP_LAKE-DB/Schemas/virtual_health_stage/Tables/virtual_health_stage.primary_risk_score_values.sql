CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.PRIMARY_RISK_SCORE_VALUES
(
ID                      INT,
WEIGHT                  INT,
WEIGHT_OLD              INT,
LABEL               VARCHAR,
IS_LOCKED               INT,
LAST_UPDATED_BY         INT,
IS_DELETED              INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
