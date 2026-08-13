CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.USER_LOG_INS_HISTORY
(
ID                              INT,
USER_ID                         INT,
CREATED_DATE          TIMESTAMP_NTZ,
IP                          VARCHAR,
USER_AGENT                  VARCHAR,
USER_AGENT_HASH             VARCHAR,
COOKIES                     VARCHAR,
SESSION_ID                  VARCHAR,
IS_SESSION_ACTIVE               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
