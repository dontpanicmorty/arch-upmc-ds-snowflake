CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CARE_TEAM_HISTORY
(
ID                                     INT,
CARE_TEAM_ID                           INT,
CLIENT_ID                              INT,
MEMBER_ID                              INT,
MEMBER_TYPE                        VARCHAR,
MEMBER_NAME                        VARCHAR,
MEMBER_ROLE                        VARCHAR,
MEMBER_ROLE_ID                         INT,
MEMBER_PHONE                       VARCHAR,
MEMBER_EMAIL                       VARCHAR,
MEMBER_ADDED_DATE            TIMESTAMP_NTZ,
MEMBER_REMOVED_DATE          TIMESTAMP_NTZ,
ADDED_BY_ID                            INT,
ADDED_BY_NAME                      VARCHAR,
REMOVED_BY_ID                          INT,
REMOVED_BY_NAME                    VARCHAR,
STATUS                                 INT,
CREATED_DATE                 TIMESTAMP_NTZ,
ICT                                    INT,
MODEL_NAME                         VARCHAR,
MEMBER_ADDRESS                     VARCHAR,
IS_INTERNAL                            INT,
MEMBER_SPECIALIZATION              VARCHAR,
REMOVED_BY_DISENROLLMENT               INT,
SYSRULES_DISABLE_FLAG                  INT,
UUID                               VARCHAR,
UPDATED_DATE                 TIMESTAMP_NTZ,
MERGE_ID                           VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
