CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_SERVICE_PLAN_MEMBER_SIGN
(
ID                                  INT,
SERVICE_PLAN_ID                     INT,
SIGNATURE                       VARCHAR,
OPTION_RENAMED                      INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
FINGERPRINT                     VARCHAR,
COMMENTS                        VARCHAR,
ATTESTS                             INT,
SYSRULES_DISABLE_FLAG               INT,
FIRST_SIGNING_DATE        TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
