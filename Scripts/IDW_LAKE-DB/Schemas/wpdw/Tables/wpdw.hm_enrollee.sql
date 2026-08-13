CREATE OR REPLACE TABLE WPDW.HM_ENROLLEE
(
ENROLLEE_KEY                          NUMBER(33,5),
ELIGIBILITY_KEY                       NUMBER(33,5),
ELIGIBILITY_START_DATE         TIMESTAMP_NTZ,
ELIGIBILITY_END_DATE           TIMESTAMP_NTZ,
MEMBER_NBR                           VARCHAR,
MEMBER_MMI                            NUMBER(33,5),
MEMBER_DOB                     TIMESTAMP_NTZ,
MEMBER_GENDER                        VARCHAR,
MEMBER_PCP_ID                        VARCHAR,
MEMBER_PCP_NAME                      VARCHAR,
MEMBER_PCP_ASSIGNMENT_DATE     TIMESTAMP_NTZ,
MEMBER_LOB                           VARCHAR,
CORPORATION_ID                       VARCHAR,
GROUP_ID                             VARCHAR,
DIVISION_ID                          VARCHAR,
PLAN_NBR                             VARCHAR,
INSERT_DATE                    TIMESTAMP_NTZ,
UPDATE_DATE                    TIMESTAMP_NTZ
)
COMMENT='Created for WPDW Migration'
;
