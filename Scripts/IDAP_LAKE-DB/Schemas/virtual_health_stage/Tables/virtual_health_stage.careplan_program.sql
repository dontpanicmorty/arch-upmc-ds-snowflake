CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_PROGRAM
(
ID                                  INT,
NAME                            VARCHAR,
TYPE                            VARCHAR,
REFERRAL_SOURCE                 VARCHAR,
CARE_GOALS                      VARCHAR,
ACTIVITY_INTERVENTION           VARCHAR,
PROGRESS                        VARCHAR,
BARRIERS                        VARCHAR,
STATUS                          VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
