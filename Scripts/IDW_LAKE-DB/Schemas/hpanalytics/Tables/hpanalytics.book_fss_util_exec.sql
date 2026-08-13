CREATE OR REPLACE TABLE HPANALYTICS.BOOK_FSS_UTIL_EXEC
(
IP_ADMITS                       NUMBER(33,5),
OP_CLAIMS                      VARCHAR,
ER_CLAIMS                      VARCHAR,
UCRC_CLAIMS                    VARCHAR,
PCP_CLAIMS                     VARCHAR,
WELL_SERVICES_CLAIMS           VARCHAR,
DIAGNOSTIC_CLAIMS              VARCHAR,
SPECIALIST_CLAIMS              VARCHAR,
OTHER_CLAIMS                   VARCHAR,
OP_BH_CLAIMS                   VARCHAR,
SHOCK_CLAIMS                   VARCHAR,
CORPORATION_ID                 VARCHAR,
GROUP_ID                       VARCHAR,
DIVISION_ID                    VARCHAR,
PLAN_NBR                       VARCHAR,
FSS                             NUMBER(33,5),
FS                              NUMBER(33,5),
SERVICE_DATE             TIMESTAMP_NTZ,
PAYMENT_DATE             TIMESTAMP_NTZ,
COMP_FACTOR                    VARCHAR
)
COMMENT='Created for HPANALYTICS Migration'
;
