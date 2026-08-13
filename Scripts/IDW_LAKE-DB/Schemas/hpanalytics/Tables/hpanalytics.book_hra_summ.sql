CREATE OR REPLACE TABLE HPANALYTICS.BOOK_HRA_SUMM
(
INSERT_DATETIME             TIMESTAMP_NTZ,
LAST_UPDATED_DATETIME       TIMESTAMP_NTZ,
CORPORATION_ID                    VARCHAR,
GROUP_ID                          VARCHAR,
DIVISION_ID                       VARCHAR,
PLAN_NBR                          VARCHAR,
MEMBER_NBR                        VARCHAR,
RELATIONSHIP_CODE                 VARCHAR,
GENDER_CODE                       VARCHAR,
AGE                                NUMBER(33,5),
LINE_OF_BUSINESS                  VARCHAR,
ASSESSMENT_MTH                    VARCHAR,
ASSESSMENT_DATE             TIMESTAMP_NTZ,
LIMEADE_USER_ID                   VARCHAR,
ASSESSMENT_AREA_DESC              VARCHAR,
ASSESSMENT_VALUE_DESC             VARCHAR,
RISK_LEVEL_DESC                   VARCHAR,
RISK_LEVEL_DETAIL                 VARCHAR,
PHYSICAL_DISABILITY_IND            NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
