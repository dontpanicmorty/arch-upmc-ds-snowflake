CREATE OR REPLACE TABLE HPANALYTICS.BOOK_TOP_PROVIDERS
(
CORPORATION_ID                           VARCHAR,
GROUP_ID                                 VARCHAR,
DIVISION_ID                              VARCHAR,
PLAN_NBR                                 VARCHAR,
SERVICE_DATE                       TIMESTAMP_NTZ,
PAYMENT_DATE                       TIMESTAMP_NTZ,
PROVIDER_NAME                            VARCHAR,
PROVIDER_SPECIALTY_DESC                  VARCHAR,
PROVIDER_TYPE                            VARCHAR,
INNETWORK_IND                            VARCHAR,
LOCATION_CODE                            VARCHAR,
ER_CLAIM                                 VARCHAR,
CLAIM_COUNT                               NUMBER(33,5),
ADMITS                                    NUMBER(33,5),
EST_PAID_GROSS                            NUMBER(33,5),
PAID_GROSS_AMOUNT                         NUMBER(33,5),
MED_DEDCT                                 NUMBER(33,5),
MED_COPAY                                 NUMBER(33,5),
MED_COINS                                 NUMBER(33,5),
PR_TOTAL_MEMBER_RESPONSIBILITY            NUMBER(33,5),
MED_HIA                                   NUMBER(33,5),
MED_HRA                                   NUMBER(33,5),
FSS                                       NUMBER(33,5),
FSS_DESC                                 VARCHAR,
FS                                        NUMBER(33,5),
FS_DESC                                  VARCHAR,
FSS_CLAIM_COUNT                           NUMBER(33,5),
CLAIM_DAYS                                NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
