CREATE OR REPLACE TABLE ADL_PROD.INFO_HOSPICE_MC_HISTORY
(
NAME_FIRST                   VARCHAR,
NAME_LAST                    VARCHAR,
MEMBERID                     VARCHAR,
HIC                          VARCHAR,
PLAN_CODE                    VARCHAR,
PLAN_START_DATE        TIMESTAMP_NTZ,
PLAN_END_DATE          TIMESTAMP_NTZ,
HOSPICE_START_DATE     TIMESTAMP_NTZ,
HOSPICE_END_DATE       TIMESTAMP_NTZ,
CONTRACT                     VARCHAR,
PBP                          VARCHAR,
SOURCE                       VARCHAR,
LOAD_DATE              TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;