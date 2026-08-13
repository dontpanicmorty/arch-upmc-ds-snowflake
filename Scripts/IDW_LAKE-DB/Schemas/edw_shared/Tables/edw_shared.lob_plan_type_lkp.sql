CREATE OR REPLACE TABLE EDW_SHARED.LOB_PLAN_TYPE_LKP
(
CLIENT_ID                       VARCHAR,
TPA_ID                          VARCHAR,
TPA_DIV                         VARCHAR,
LINE_OF_BUSINESS_CODE           VARCHAR,
PLAN_TYPE                       VARCHAR,
PLAN_TYPE_DESC                  VARCHAR,
PLAN_TYPE_SOURCE                VARCHAR,
LOAD_DATE                 TIMESTAMP_NTZ,
PROGRAM_CODE                    VARCHAR,
PROGRAM_DESC                    VARCHAR,
MEDICAL_HOME_DESC               VARCHAR
)
COMMENT='Created for EDW_SHARED Migration'
;
