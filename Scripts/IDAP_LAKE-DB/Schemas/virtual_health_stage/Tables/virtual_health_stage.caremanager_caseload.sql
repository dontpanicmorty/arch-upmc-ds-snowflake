CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREMANAGER_CASELOAD
(
CAREMANAGER_ID                  INT,
USER_ID                         INT,
NAME                        VARCHAR,
ROLES                       VARCHAR,
ZONES                       VARCHAR,
CLIENT_COUNT                    INT,
CASELOAD_SCORE                  INT,
UPDATED_DATE          TIMESTAMP_NTZ,
DIRTY_FLAG                      INT,
SERVICE_AREAS               VARCHAR,
PLAN_IDS                    VARCHAR,
THRESHOLD                       INT,
RECALCULATED_DATE     TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
