CREATE OR REPLACE TABLE HPANALYTICS.BOOK_PAID
(
CORPORATION_ID           VARCHAR,
GROUP_ID                 VARCHAR,
DIVISION_ID              VARCHAR,
PLAN_NBR                 VARCHAR,
SERVICE_DATE       TIMESTAMP_NTZ,
PAYMENT_DATE       TIMESTAMP_NTZ,
MEDICAL_XCF               NUMBER(33,5),
MEDICAL                   NUMBER(33,5),
PHARMACY                  NUMBER(33,5),
MED_DEDCT                 NUMBER(33,5),
MED_COPAY                 NUMBER(33,5),
MED_COINS                 NUMBER(33,5),
MED_HIA                   NUMBER(33,5),
MED_HRA                   NUMBER(33,5),
PHARM_DEDCT               NUMBER(33,5),
PHARM_COPAY               NUMBER(33,5),
PHARM_HIA                 NUMBER(33,5),
PHARM_HRA                 NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
