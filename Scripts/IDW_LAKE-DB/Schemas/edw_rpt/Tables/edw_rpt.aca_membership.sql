CREATE OR REPLACE TABLE EDW_RPT.ACA_MEMBERSHIP
(
HIX_MEMBER_KEY                           NUMBER,
HIX_MEMBER_ID                           VARCHAR,
HIX_FAMILY_ID                           VARCHAR,
HIX_POLICY_ID                           VARCHAR,
QUALITY_HEALTH_PLAN_ID                  VARCHAR,
STANDARD_COMPONENT_ID                   VARCHAR,
VARIANT_ID                              VARCHAR,
COST_SHARING_REDUCTION             NUMBER(11,2),
TOTAL_RESPONSIBLE_PREMIUM_AMT      NUMBER(11,2),
PREMIUM_AMT                        NUMBER(11,2),
PREMIUM_AMOUNT_TOTAL               NUMBER(11,2),
ADVANCED_PREMIUM_TAX_CREDIT        NUMBER(11,2),
TOBACCO_INDICATOR                       VARCHAR,
EFFECTIVE_START_DATE              TIMESTAMP_NTZ,
EFFECTIVE_END_DATE                TIMESTAMP_NTZ,
LOAD_DATE                         TIMESTAMP_NTZ,
UPDATE_DATE                       TIMESTAMP_NTZ,
MEMBER_NBR                              VARCHAR,
BROKER_NPN                         NUMBER(16,2),
ON_VS_OFF_EXCHANGE                      VARCHAR,
MARKET_SEGMENT                          VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
