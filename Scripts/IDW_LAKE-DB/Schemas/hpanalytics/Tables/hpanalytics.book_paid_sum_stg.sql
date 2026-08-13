CREATE OR REPLACE TABLE HPANALYTICS.BOOK_PAID_SUM_STG
(
MEMBER_NBR                        VARCHAR,
CORPORATION_ID                    VARCHAR,
GROUP_ID                          VARCHAR,
DIVISION_ID                       VARCHAR,
PLAN_NBR                          VARCHAR,
PAYMENT_DATE                TIMESTAMP_NTZ,
PROVIDER_NAME                     VARCHAR,
PROVIDER_TYPE                     VARCHAR,
LOCATION_CODE                     VARCHAR,
ADMITS                             NUMBER(33,5),
CLAIM_DAY_CNT                      NUMBER(33,5),
FSS                                NUMBER(33,5),
FS_DESC                           VARCHAR,
IP_CLAIM_NBR                      VARCHAR,
OP_CLAIM_NBR                      VARCHAR,
PROF_CLAIM_NBR                    VARCHAR,
IP_PAID_GROSS_AMT                  NUMBER(33,5),
OP_PAID_GROSS_AMT                  NUMBER(33,5),
PROF_PAID_GROSS_AMT                NUMBER(33,5),
IP_MBR_RESPONSIBILITY              NUMBER(33,5),
OP_MBR_RESPONSIBILITY              NUMBER(33,5),
PROF_MBR_RESPONSIBILITY            NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
