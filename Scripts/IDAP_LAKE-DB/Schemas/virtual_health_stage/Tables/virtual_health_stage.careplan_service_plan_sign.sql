CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_SERVICE_PLAN_SIGN
(
ID                                  INT,
SERVICE_PLAN_ID                     INT,
AUTHOR_ID                           INT,
SIGNUSER_ID                         INT,
SIGNATURE                       VARCHAR,
MODE                                INT,
STATUS                              INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
FINGER_SIGN                     VARCHAR,
SYSRULES_DISABLE_FLAG               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
