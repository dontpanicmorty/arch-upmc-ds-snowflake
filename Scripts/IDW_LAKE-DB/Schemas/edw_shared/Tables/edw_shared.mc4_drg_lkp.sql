CREATE OR REPLACE TABLE EDW_SHARED.MC4_DRG_LKP
(
DRG                            VARCHAR,
DRG_DESC                       VARCHAR,
MDC                            VARCHAR,
MDC_DESC                       VARCHAR,
DRG_CATEGORY                   VARCHAR,
VERSION                         NUMBER,
EFFECTIVE_START_DATE     TIMESTAMP_NTZ,
EFFECTIVE_END_DATE       TIMESTAMP_NTZ,
LOAD_DATE                TIMESTAMP_NTZ,
RELATIVE_VALUE                 VARCHAR
)
COMMENT='Created for EDW_SHARED Migration'
;
