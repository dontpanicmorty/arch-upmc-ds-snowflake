CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ASSIGNMENT_HOLDING_TANK
(
ID                                  INT,
USER_ID                             INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
REFERRAL_RANKING                    INT,
SUB_TYPE_RANKING                    INT,
ROLE_ID                             INT,
DAYS_IN_HOLDING_TANK                INT,
SYSRULES_DISABLE_FLAG               INT,
EPISODE_ID                          INT,
ASSIGNMENT_TYPE                     INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
