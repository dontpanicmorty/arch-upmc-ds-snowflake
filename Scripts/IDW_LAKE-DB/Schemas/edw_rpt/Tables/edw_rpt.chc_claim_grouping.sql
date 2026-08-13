CREATE OR REPLACE TABLE EDW_RPT.CHC_CLAIM_GROUPING
(
CHC_CLAIM_GROUPING_KEY                   NUMBER,
CLAIM_STATUS                            VARCHAR,
DISCHARGE_STATUS_CODE                   VARCHAR,
DISCHARGE_STATUS_DESC                   VARCHAR,
LOAD_DATE                         TIMESTAMP_NTZ,
UPDATE_DATE                       TIMESTAMP_NTZ,
CLAIM_LINE_STATUS                       VARCHAR,
CLAIM_LINE_STATUS_DESC                  VARCHAR,
PRIMARY_ALT_CARRIER_TYPE_DESC           VARCHAR,
BENEFIT_LEVEL_CODE                      VARCHAR,
BENEFIT_LEVEL_DESC                      VARCHAR,
BENEFIT_PAYMENT_INDICATOR               VARCHAR,
BENEFIT_CATEGORY_CODE                   VARCHAR,
BENEFIT_CATEGORY_DESC                   VARCHAR,
SERVICE_STATUS                          VARCHAR,
BILL_TYPE                               VARCHAR,
BILL_TYPE_DESC                          VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
