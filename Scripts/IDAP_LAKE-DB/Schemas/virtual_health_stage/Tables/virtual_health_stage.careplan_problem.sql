CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_PROBLEM
(
ID                                    INT,
CAREPLAN_ID                           INT,
EPISODE_ID                            INT,
CREATED_DATE                TIMESTAMP_NTZ,
UPDATED_DATE                TIMESTAMP_NTZ,
PRIORITY                          VARCHAR,
NEED                              VARCHAR,
PROBLEM                           VARCHAR,
PROBLEM_STATUS                    VARCHAR,
IS_AUTOPOPULATE                       INT,
REFERRAL_SOURCE                   VARCHAR,
START_DATE                  TIMESTAMP_NTZ,
END_DATE                    TIMESTAMP_NTZ,
LAST_UPDATED_BY                       INT,
IS_DELETED                            INT,
CLOSED_BY_DISENROLLMENT               INT,
MERGE_ID                          VARCHAR,
SYSRULES_DISABLE_FLAG                 INT,
EXTERNAL_ID                       VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
