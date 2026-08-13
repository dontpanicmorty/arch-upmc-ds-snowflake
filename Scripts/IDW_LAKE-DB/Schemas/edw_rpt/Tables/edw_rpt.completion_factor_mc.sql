CREATE OR REPLACE TABLE EDW_RPT.COMPLETION_FACTOR_MC
(
ACTUAL_FACTOR                      NUMBER(1),
AVERAGE_FACTOR                     NUMBER(1),
COMPLETION_FACTOR                NUMBER(9,7),
FINANCIAL_SERVICE_SUBGROUP         NUMBER(7),
LOAD_DATE                      TIMESTAMP_NTZ,
LOAD_FLAG                            VARCHAR,
MONTH_INTERVAL                     NUMBER(2)
)
COMMENT='Created for EDWRPT Migration'
;
