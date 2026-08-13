CREATE OR REPLACE TABLE EDW_RPT.ICD_PROCEDURE_GROUP
(
ICD_PROCEDURE_GROUP_KEY            NUMBER,
ICD_PROCEDURE_KEY                  NUMBER,
ICD_QUALIFIER_KEY                  NUMBER,
WEIGHTING_FACTOR                NUMBER(1),
ICD_POSITION                       NUMBER,
LOAD_DATE                   TIMESTAMP_NTZ,
ICD_CNT                            NUMBER
)
COMMENT='Created for EDWRPT Migration'
;
