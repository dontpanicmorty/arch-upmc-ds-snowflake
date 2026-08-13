CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SYSTEM_RULE_TRIGGER
(
ID                             INT,
NAME                       VARCHAR,
TYPE                       VARCHAR,
DESCRIPTION               VARCHAR,
CREATED_DATE         TIMESTAMP_NTZ,
UPDATED_DATE         TIMESTAMP_NTZ,
UPDATED_BY                     INT,
IS_DELETED                     INT,
RULE                       VARCHAR,
CONDITION_GROUP            VARCHAR,
DISABLE_SNAPSHOT               INT,
IS_INTERNAL                    INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
