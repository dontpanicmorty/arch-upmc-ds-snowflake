CREATE OR REPLACE TABLE EDW_RPT.ICD_DIAGNOSIS_GROUP
(
ICD_DIAGNOSIS_GROUP_KEY            NUMBER,
ICD_DIAGNOSIS_KEY                  NUMBER,
ICD_QUALIFIER_KEY                  NUMBER,
WEIGHTING_FACTOR                NUMBER(1),
DIAGNOSIS_LEVEL                   VARCHAR,
ICD_POSITION                       NUMBER,
POA_IND                           VARCHAR,
LOAD_DATE                   TIMESTAMP_NTZ,
ICD_CNT                            NUMBER
)
COMMENT='Created for EDWRPT Migration'
;
