CREATE OR REPLACE TABLE EDW_RPT.MC_PLAN
(
MC_PLAN_KEY                      NUMBER,
CORPORATION_ID                  VARCHAR,
CORPORATION_NAME                VARCHAR,
GROUP_ID                        VARCHAR,
GROUP_DESC                      VARCHAR,
DIVISION_ID                     VARCHAR,
DIVISION_DESC                   VARCHAR,
PLAN_NBR                        VARCHAR,
UPDATE_DATE               TIMESTAMP_NTZ,
EFFECTIVE_START_DATE      TIMESTAMP_NTZ,
EFFECTIVE_END_DATE        TIMESTAMP_NTZ,
LOAD_DATE                 TIMESTAMP_NTZ,
BUSINESS_INSURED_TYPE           VARCHAR,
BUSINESS_UNIT_CODE              VARCHAR,
BUSINESS_UNIT_DESC              VARCHAR,
CARRIER_CODE                    VARCHAR,
CARRIER_DESC                    VARCHAR,
PROGRAM_CODE                    VARCHAR,
PROGRAM_DESC                    VARCHAR,
REGION_CODE                     VARCHAR,
REGION_DESC                     VARCHAR,
MEDICAL_COPAY_DESC              VARCHAR,
BEHAV_HLTH_COPAY_DESC           VARCHAR,
COINSURANCE_DESC                VARCHAR,
PRODUCT_CODE                    VARCHAR,
PRODUCT_DESC                    VARCHAR,
PLAN_CATEGORY                   VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
