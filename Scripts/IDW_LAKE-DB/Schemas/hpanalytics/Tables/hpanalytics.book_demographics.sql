CREATE OR REPLACE TABLE HPANALYTICS.BOOK_DEMOGRAPHICS
(
MEMBER_NBR                  VARCHAR,
CORPORATION_ID              VARCHAR,
GROUP_ID                    VARCHAR,
DIVISION_ID                 VARCHAR,
PLAN_NBR                    VARCHAR,
MEMBERSHIP_DATE       TIMESTAMP_NTZ,
RELATIONSHIP_CODE           VARCHAR,
PLAN_TIER_CODE              VARCHAR,
AGE                          NUMBER(33,5),
GENDER_CODE                 VARCHAR,
COUNTY                      VARCHAR,
MEMBER_CNT                   NUMBER(33,5),
CONTRACT_CNT                 NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
