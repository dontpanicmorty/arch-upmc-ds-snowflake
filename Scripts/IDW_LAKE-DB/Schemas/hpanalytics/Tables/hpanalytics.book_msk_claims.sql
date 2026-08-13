CREATE OR REPLACE TABLE HPANALYTICS.BOOK_MSK_CLAIMS
(
MEMBER_NBR                  VARCHAR,
RELATIONSHIP_CODE           VARCHAR,
RELATIONSHIP_DESC           VARCHAR,
CLAIM_NBR                   VARCHAR,
CORPORATION_ID              VARCHAR,
CORPORATION_NAME            VARCHAR,
GROUP_ID                    VARCHAR,
GROUP_DESC                  VARCHAR,
DIVISION_ID                 VARCHAR,
DIVISION_DESC               VARCHAR,
PLAN_NBR                    VARCHAR,
FS                           NUMBER(33,5),
FSS                          NUMBER(33,5),
FSS_DESC                    VARCHAR,
MEDICAL_CATEGORY            VARCHAR,
BODY_GROUP                  VARCHAR,
BODY_PART                   VARCHAR,
BODY_SUBGROUP               VARCHAR,
SVCDATE               TIMESTAMP_NTZ,
PDDATE                TIMESTAMP_NTZ,
ADMITS                       NUMBER(33,5),
DAYS                         NUMBER(33,5),
PAID_GROSS                   NUMBER(33,5),
EST_PAID_GROSS               NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
