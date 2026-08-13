CREATE OR REPLACE TABLE HPANALYTICS.BOOK_ER
(
CORPORATION_ID           VARCHAR,
GROUP_ID                 VARCHAR,
DIVISION_ID              VARCHAR,
PLAN_NBR                 VARCHAR,
COMP_FACTOR              VARCHAR,
MEMBER_NBR               VARCHAR,
CLAIM_NBR                VARCHAR,
FS                        NUMBER(33,5),
FSS                       NUMBER(33,5),
FSS_DESC                 VARCHAR,
SERVICE_DATE       TIMESTAMP_NTZ,
PAYMENT_DATE       TIMESTAMP_NTZ,
CPT4_CODE                VARCHAR,
SEVERITY_DESC            VARCHAR,
PROVIDER_NAME            VARCHAR,
PAID_GROSS                NUMBER(33,5),
EST_PAID_GROSS            NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
