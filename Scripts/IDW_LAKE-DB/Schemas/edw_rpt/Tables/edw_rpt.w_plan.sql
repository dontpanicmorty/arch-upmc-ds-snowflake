CREATE OR REPLACE TABLE EDW_RPT.W_PLAN
(
W_PLAN_KEY                       NUMBER,
BUSINESS_INSURED_TYPE           VARCHAR,
CORPORATION_ID                  VARCHAR,
CORPORATION_NAME                VARCHAR,
GROUP_ID                        VARCHAR,
GROUP_DESC                      VARCHAR,
DIVISION_ID                     VARCHAR,
DIVISION_DESC                   VARCHAR,
PLAN_NBR                        VARCHAR,
PLAN_TIER_CODE                  VARCHAR,
PLAN_TIER_DESC                  VARCHAR,
EFFECTIVE_START_DATE      TIMESTAMP_NTZ,
EFFECTIVE_END_DATE        TIMESTAMP_NTZ,
LOAD_DATE                 TIMESTAMP_NTZ,
UPDATE_DATE               TIMESTAMP_NTZ,
BUSINESS_UNIT_CODE              VARCHAR,
BUSINESS_UNIT_DESC              VARCHAR,
PROGRAM_CODE                    VARCHAR,
PROGRAM_DESC                    VARCHAR,
PRODUCT_CODE                    VARCHAR,
PRODUCT_DESC                    VARCHAR,
PLAN_CATEGORY                   VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
