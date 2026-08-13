CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_SIGN
(
ID                                  INT,
CAREPLAN_ID                         INT,
SIGNATURE                       VARCHAR,
AUTHOR_ID                           INT,
SIGNUSER_ID                         INT,
MODE                            VARCHAR,
STATUS                              INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
FINGER_SIGN                     VARCHAR,
SYSRULES_DISABLE_FLAG               INT,
MERGE_ID                        VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
