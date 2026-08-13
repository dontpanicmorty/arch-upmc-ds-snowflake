CREATE OR REPLACE TABLE EDW_RPT.DRG
(
DRG_KEY                         NUMBER,
DRG_CODE                       VARCHAR,
SEVERITY_OF_ILLNESS            VARCHAR,
DRG_TYPE                       VARCHAR,
DRG_DESC                       VARCHAR,
DRG_CATEGORY                   VARCHAR,
MDC_CODE                       VARCHAR,
MDC_DESC                       VARCHAR,
RELATIVE_VALUE                 VARCHAR,
AVERAGE_LENGTH_STAY            VARCHAR,
EFFECTIVE_START_DATE     TIMESTAMP_NTZ,
EFFECTIVE_END_DATE       TIMESTAMP_NTZ,
LOAD_DATE                TIMESTAMP_NTZ,
UPDATE_DATE              TIMESTAMP_NTZ,
DRG_VERSION                     NUMBER
)
COMMENT='Created for EDWRPT Migration'
;
