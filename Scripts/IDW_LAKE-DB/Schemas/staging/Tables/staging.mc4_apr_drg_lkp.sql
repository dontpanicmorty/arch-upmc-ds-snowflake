CREATE OR REPLACE TABLE STAGING.MC4_APR_DRG_LKP
(
DRG                            VARCHAR,
SOI                             NUMBER,
DRG_DESC                       VARCHAR,
RELATIVE_VALUE                  NUMBER,
AVG_LOS                    NUMBER(9,5),
DRG_CATEGORY                   VARCHAR,
MDC                            VARCHAR,
MDC_DESC                       VARCHAR,
VERSION                         NUMBER,
EFFECTIVE_START_DATE     TIMESTAMP_NTZ,
EFFECTIVE_END_DATE       TIMESTAMP_NTZ,
LOAD_DATE                TIMESTAMP_NTZ
)
COMMENT='Created for STAGING Migration'
;
