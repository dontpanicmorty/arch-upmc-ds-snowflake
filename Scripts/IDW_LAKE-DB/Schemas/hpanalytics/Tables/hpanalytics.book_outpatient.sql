CREATE OR REPLACE TABLE HPANALYTICS.BOOK_OUTPATIENT
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
PROVIDER_NAME            VARCHAR,
PROVIDER_TYPE            VARCHAR,
LOCATION_CODE            VARCHAR,
PAID_GROSS                NUMBER(33,5),
CLAIMS                    NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
