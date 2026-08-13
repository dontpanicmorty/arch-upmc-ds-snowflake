CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_PROBLEM_DETAIL
(
ID                                  INT,
PROBLEM_ID                          INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
CARE_GOAL                       VARCHAR,
GOAL_TYPE                       VARCHAR,
BARRIERS                         VARCHAR,
ACTIVITY                        VARCHAR,
EXPECTED_OUTCOME                VARCHAR,
TARGET_DATE               TIMESTAMP_NTZ,
PROGRESS                        VARCHAR,
STATUS                          VARCHAR,
LAST_UPDATED_BY                     INT,
IS_DELETED                          INT,
CAREPLAN_ID                         INT,
MERGE_ID                        VARCHAR,
RANK_RENAMED                        INT,
RESPONSIBLE_PARTY               VARCHAR,
PROGRESS_UPDATED_DATE     TIMESTAMP_NTZ,
EXTERNAL_ID                     VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
