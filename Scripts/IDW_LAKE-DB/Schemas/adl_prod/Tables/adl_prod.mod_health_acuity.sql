CREATE OR REPLACE TABLE ADL_PROD.MOD_HEALTH_ACUITY
(
MMI                               VARCHAR,
INDEX_DATE                  TIMESTAMP_NTZ,
AGE_GROUP                         VARCHAR,
HEALTH_ACUITY_TIER_CODE            NUMBER,
HEALTH_ACUITY_TIER_DESC           VARCHAR,
LOAD_DATE                   TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
