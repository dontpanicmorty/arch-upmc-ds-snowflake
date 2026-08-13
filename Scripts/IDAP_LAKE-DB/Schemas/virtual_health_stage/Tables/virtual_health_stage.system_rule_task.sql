CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SYSTEM_RULE_TASK
(
SYSTEM_RULE_ID                         INT,
DUE_DATE                               INT,
DUE_DATE_BUSINESS                      INT,
TASK_TYPE                              INT,
TASK_DESCRIPTION                   VARCHAR,
TASK_PRIORITY                          INT,
HAS_AUTO_RESOLVE                       INT,
REFERENCE_DATE_TYPE                    INT,
REFERENCE_DATE_TYPE_FOREIGN_ID         INT,
REFERENCE_OPERATION_TYPE               INT,
DUE_DATE_REQUIRED                      INT,
LAST_UPDATED_BY                        INT,
DUE_IN_MONTHS                          INT,
DUE_DAY                                INT,
EXTERNAL_ID_CHECK                      INT,
DUE_BY_AUTO_UPDATE                     INT,
EPISODE_OWNER                          INT,
EPISODE_OWNER_BACKUP                   INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
