CREATE OR REPLACE TABLE HPANALYTICS.BOOK_CLAIMS_STRAT
(
CORPORATION_ID                     VARCHAR,
MEMBER_NBR                         VARCHAR,
GROUP_ID                           VARCHAR,
DIVISION_ID                        VARCHAR,
PLAN_NBR                           VARCHAR,
SERVICE_DATE                 TIMESTAMP_NTZ,
PAYMENT_DATE                 TIMESTAMP_NTZ,
TOTAL_PAID                          NUMBER(33,5),
TOTAL_PAID_XCF                      NUMBER(33,5),
PROVIDER_NAME                      VARCHAR,
ICD_DIAGNOSIS_GROUP_CODE           VARCHAR,
ICD_DIAGNOSIS_GROUP_DESC           VARCHAR,
CURRENT_MEMBER                     VARCHAR,
MEDICAL_PAID                        NUMBER(33,5),
MEDICAL_PAID_XCF                    NUMBER(33,5),
PHARM_PAID                          NUMBER(33,5),
SSN_LST_4                          VARCHAR,
RELATIONSHIP_CODE                  VARCHAR,
RELATIONSHIP_DESC                  VARCHAR,
RX_CLM_CNT_FIRST_DATE               NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
