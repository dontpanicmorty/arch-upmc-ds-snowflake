CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.REGION
(
ID                            INT,
COUNTRY_ID                    INT,
TITLE                     VARCHAR,
CODE                      VARCHAR,
ADM_1_CODE                VARCHAR,
IS_HIDDEN                     INT,
LAST_UPDATED_BY               INT,
CREATED_AT          TIMESTAMP_NTZ,
UPDATED_AT          TIMESTAMP_NTZ,
IS_MARKET                     INT,
IS_STATE                      INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
