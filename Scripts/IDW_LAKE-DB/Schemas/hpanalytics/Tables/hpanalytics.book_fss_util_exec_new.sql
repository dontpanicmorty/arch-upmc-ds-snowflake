CREATE OR REPLACE TABLE HPANALYTICS.BOOK_FSS_UTIL_EXEC_NEW
(
IP_ADMITS                         NUMBER(33,5),
OBSERVATION_CLAIMS               VARCHAR,
OP_SURG_CLAIMS                   VARCHAR,
OP_AMB_SURG_CLAIMS               VARCHAR,
OTHER_OP_CLAIMS                  VARCHAR,
EMERGENCY_CLAIMS                 VARCHAR,
URGENT_RETAIL_CLAIMS             VARCHAR,
PCP_CLAIMS                       VARCHAR,
WELL_SERVICES_CLAIMS             VARCHAR,
DIAGNOSTIC_CLAIMS                VARCHAR,
SPECIALIST_CLAIMS                VARCHAR,
MSS_CLAIMS                       VARCHAR,
OP_BH_CLAIMS                     VARCHAR,
THERAPY_CLAIMS                   VARCHAR,
MEDICAL_THERAPY_CLAIMS           VARCHAR,
SHOCK_CLAIMS                     VARCHAR,
CORPORATION_ID                   VARCHAR,
GROUP_ID                         VARCHAR,
DIVISION_ID                      VARCHAR,
PLAN_NBR                         VARCHAR,
FSS                               NUMBER(33,5),
FS                                NUMBER(33,5),
SERVICE_DATE               TIMESTAMP_NTZ,
PAYMENT_DATE               TIMESTAMP_NTZ,
COMP_FACTOR                      VARCHAR,
PROVIDER_NAME                    VARCHAR,
CLAIM_NBR                        VARCHAR
)
COMMENT='Created for HPANALYTICS Migration'
;
