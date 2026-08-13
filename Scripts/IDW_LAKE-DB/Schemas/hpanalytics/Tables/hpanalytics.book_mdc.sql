CREATE OR REPLACE TABLE HPANALYTICS.BOOK_MDC
(
CORPORATION_ID           VARCHAR,
GROUP_ID                 VARCHAR,
DIVISION_ID              VARCHAR,
PLAN_NBR                 VARCHAR,
CLAIM_NBR                VARCHAR,
SERVICE_DATE       TIMESTAMP_NTZ,
PAYMENT_DATE       TIMESTAMP_NTZ,
PROVIDER_NAME            VARCHAR,
DRG_CODE                 VARCHAR,
DRG_VERSION               NUMBER(33,5),
MDC_CODE                 VARCHAR,
MDC_DESC                 VARCHAR,
PAID_GROSS                NUMBER(33,5),
EST_PAID_GROSS            NUMBER(33,5),
ADMITS                    NUMBER(33,5),
ADMITS_W                  NUMBER(33,5),
COMP_FACTOR              VARCHAR,
FSS                      NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
