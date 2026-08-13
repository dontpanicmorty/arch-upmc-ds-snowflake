CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SYSTEM_RULE
(
ID                                          INT,
NAME                                    VARCHAR,
RULE                                    VARCHAR,
DISPOSITION                                 INT,
RANK_RENAMED                                INT,
CREATED_DATE                      TIMESTAMP_NTZ,
UPDATED_DATE                      TIMESTAMP_NTZ,
STATUS                                      INT,
TYPE                                    VARCHAR,
DESCRIPTION                            VARCHAR,
FREQUENCY                               VARCHAR,
LAST_UPDATED_BY                             INT,
TRIGGER_LABELS                          VARCHAR,
CRITERION_LABELS                        VARCHAR,
AUTO_RESOLVE_TRIGGER_LABELS             VARCHAR,
AUTO_RESOLVE_CRITERION_LABELS           VARCHAR,
IS_INTERNAL                                 INT,
ACCEPT_ON_CRITERIA_FAILURE                  INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
