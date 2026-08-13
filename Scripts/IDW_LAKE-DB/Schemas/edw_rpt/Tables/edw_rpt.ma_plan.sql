CREATE OR REPLACE TABLE EDW_RPT.MA_PLAN
(
MA_PLAN_KEY                     NUMBER,
ASSISTANCE_CATEGORY            VARCHAR,
PROGRAM_STATUS                 VARCHAR,
DIVISION_ID                    VARCHAR,
DIVISION_DESC                  VARCHAR,
SELECTION_TYPE                 VARCHAR,
RECIPIENT_GROUP_DESC           VARCHAR,
RECIPIENT_GROUP_CODE           VARCHAR,
PLAN_NBR                       VARCHAR,
LOAD_DATE                TIMESTAMP_NTZ,
UPDATE_DATE              TIMESTAMP_NTZ,
COUNTY_CODE                    VARCHAR,
COUNTY_DESC                    VARCHAR,
DPW_COUNTY_CODE                VARCHAR,
MEDICARE_INDICATOR             VARCHAR,
RECIPIENT_GROUP_NBR            VARCHAR,
CONTRACT_TYPE                  VARCHAR,
DPW_PLAN_CODE                  VARCHAR,
DPW_PLAN_DESC                  VARCHAR,
PRODUCT_CODE                   VARCHAR,
PRODUCT_DESC                   VARCHAR,
PLAN_CATEGORY                  VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
