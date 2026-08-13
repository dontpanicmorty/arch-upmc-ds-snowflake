CREATE OR REPLACE TABLE HPANALYTICS.BOOK_FSS
(
CORPORATION_ID           VARCHAR,
GROUP_ID                 VARCHAR,
DIVISION_ID              VARCHAR,
PLAN_NBR                 VARCHAR,
INPATIENT                 NUMBER(33,5),
OUTPATIENT                NUMBER(33,5),
ER                        NUMBER(33,5),
OTHER                     NUMBER(33,5),
DIAGNOSTIC                NUMBER(33,5),
PCPOBGYN                  NUMBER(33,5),
SPECIALIST                NUMBER(33,5),
WELL_SERVICES             NUMBER(33,5),
BH                        NUMBER(33,5),
SHOCK                     NUMBER(33,5),
TOTAL_PAID                NUMBER(33,5),
SERVICE_DATE       TIMESTAMP_NTZ,
PAYMENT_DATE       TIMESTAMP_NTZ,
FSS                       NUMBER(33,5),
FS                        NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
