CREATE OR REPLACE TABLE HPANALYTICS.BOOK_FSS_NEW
(
CORPORATION_ID            VARCHAR,
GROUP_ID                  VARCHAR,
DIVISION_ID               VARCHAR,
PLAN_NBR                  VARCHAR,
INPATIENT                  NUMBER(33,5),
OBSERVATION                NUMBER(33,5),
OP_SURG                    NUMBER(33,5),
OP_AMB_SURG                NUMBER(33,5),
OTHER_OP                   NUMBER(33,5),
EMERGENCY                  NUMBER(33,5),
URGENT_RETAIL              NUMBER(33,5),
DIAGNOSTIC                 NUMBER(33,5),
PCP                        NUMBER(33,5),
SPECIALIST                 NUMBER(33,5),
WELL_SERVICES              NUMBER(33,5),
MSS                        NUMBER(33,5),
OP_BH                      NUMBER(33,5),
THERAPY                    NUMBER(33,5),
MEDICAL_THERAPY            NUMBER(33,5),
SHOCK                      NUMBER(33,5),
TOTAL_PAID                 NUMBER(33,5),
SERVICE_DATE        TIMESTAMP_NTZ,
PAYMENT_DATE        TIMESTAMP_NTZ,
FSS                        NUMBER(33,5),
FS                         NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
