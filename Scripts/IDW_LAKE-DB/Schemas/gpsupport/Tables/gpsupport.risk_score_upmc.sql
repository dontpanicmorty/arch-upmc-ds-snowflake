CREATE OR REPLACE TABLE GPSUPPORT.RISK_SCORE_UPMC
(
MEDICAID_ID                VARCHAR,
RATE_CELL                  VARCHAR,
MODEL                      VARCHAR,
REGION                     VARCHAR,
AGE                         NUMBER,
GENDER                     VARCHAR,
ACUITY_FACTOR               NUMBER,
AGE_GENDER_GROUP           VARCHAR,
MEM_MOS                     NUMBER,
LOADDATE             TIMESTAMP_NTZ
)
COMMENT='Created for GPSUPPORT Migration'
;
