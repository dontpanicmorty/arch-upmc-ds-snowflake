CREATE OR REPLACE TABLE EDW_RPT.CHC_MCO_PLAN
(
CHC_MCO_PLAN_KEY                      NUMBER(38),
PROGRAM_STATUS_MCO                       VARCHAR,
RECIPENT_GROUP_CODE_MCO                  VARCHAR,
RECIPENT_GROUP_DESC_MCO                  VARCHAR,
COUNTY_CODE_MCO                          VARCHAR,
ASSISTANCE_CATEGORY_MCO                  VARCHAR,
DEPRIVATION_QUALIFYING_CODE_MC           VARCHAR,
LOAD_DATE                          TIMESTAMP_NTZ,
UPDATE_DATE                        TIMESTAMP_NTZ,
COUNTY_DESC_MCO                          VARCHAR,
MEDICARE_IND_MCO                         VARCHAR,
DPW_PLAN_CODE                            VARCHAR,
DPW_PLAN_DESC                            VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
