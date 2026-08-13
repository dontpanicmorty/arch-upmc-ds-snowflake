CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SYSTEM_RULE_CRITERIA
(
ID                            INT,
NAME                      VARCHAR,
DESCRIPTION               VARCHAR,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
UPDATED_BY                    INT,
RULE                      VARCHAR,
IS_DELETED                    INT,
SINGLE_OBJECT                 INT,
ALL_MATCH                     INT,
CONDITION_GROUP           VARCHAR,
DATA_CONTEXT                  INT,
MOST_RECENT                   INT,
IS_INTERNAL                   INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
