CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ASSIGNMENT_WS_CARE_MANAGER_ASSIGNMENT_PROFILE
(
ID                                    INT,
CAREMANAGER_ID                        INT,
ASSIGNMENT_PATHWAY_SYSTEM_RULE_ID     INT,
ASSIGNMENT_PROFILE_ID                 INT,
RANK_RENAMED                          INT,
ROLES_AMOUNT                          INT,
ROLES_MATCHED                         INT,
ATTRIBUTES_AMOUNT                     INT,
ATTRIBUTES_MATCHED                    INT,
PLANS_AMOUNT                          INT,
PLANS_MATCHED                         INT,
CREDENTIALS_AMOUNT                    INT,
CREDENTIALS_MATCHED                   INT,
SERVICE_AREA_AMOUNT                   INT,
SERVICE_AREA_MATCHED                  INT,
LANGUAGES_AMOUNT                      INT,
LANGUAGES_MATCHED                     INT,
IS_DISTANCE_LIMIT                     INT,
ASSIGNMENT_TYPE                       INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
