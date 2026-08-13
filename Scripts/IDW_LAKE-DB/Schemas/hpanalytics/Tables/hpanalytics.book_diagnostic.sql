CREATE OR REPLACE TABLE HPANALYTICS.BOOK_DIAGNOSTIC
(
CORPORATION_ID               VARCHAR,
GROUP_ID                     VARCHAR,
DIVISION_ID                  VARCHAR,
PLAN_NBR                     VARCHAR,
COMP_FACTOR                  VARCHAR,
CLAIM_NBR                    VARCHAR,
PAID_GROSS                    NUMBER(33,5),
EST_PAID_GROSS                NUMBER(33,5),
SERVICE_DATE           TIMESTAMP_NTZ,
PAYMENT_DATE           TIMESTAMP_NTZ,
FSS                           NUMBER(33,5),
FS                            NUMBER(33,5),
FSS_DESC                     VARCHAR,
HIGH_TECH_CATEGORY           VARCHAR
)
COMMENT='Created for HPANALYTICS Migration'
;
