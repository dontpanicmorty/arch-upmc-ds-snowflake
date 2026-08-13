CREATE OR REPLACE TABLE EDW_RPT.MA_CPT4_MODIFIER_GROUP
(
MA_CLAIM_FACT_KEY            NUMBER,
CPT4_CODE                   VARCHAR,
MODIFIER1                   VARCHAR,
MODIFIER2                   VARCHAR,
MODIFIER3                   VARCHAR,
MODIFIER4                   VARCHAR,
LOAD_DATE             TIMESTAMP_NTZ
)
COMMENT='Created for EDWRPT Migration'
;
