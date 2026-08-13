CREATE OR REPLACE TABLE EDW_SHARED.DNV_LOB_PLAN_TYPE_LKP
(
CLIENT_ID                       VARCHAR,
TPA_ID                          VARCHAR,
TPA_DIV                         VARCHAR,
LINE_OF_BUSINESS_CODE           VARCHAR,
PLAN_TYPE                       VARCHAR,
PLAN_TYPE_DESC                  VARCHAR,
PLAN_TYPE_SOURCE                VARCHAR,
LOAD_DATE                 TIMESTAMP_NTZ
)
COMMENT='Created for EDW_SHARED Migration'
;
