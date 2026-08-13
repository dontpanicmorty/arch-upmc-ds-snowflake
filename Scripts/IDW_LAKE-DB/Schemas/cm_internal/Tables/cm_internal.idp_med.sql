CREATE OR REPLACE TABLE CM_INTERNAL.IDP_MED
(
HCID                      VARCHAR,
MEM_MONTH                 VARCHAR,
CLAIM_CNT                  NUMBER(33,5),
SHOCK_CLAIM_CNT            NUMBER(33,5),
ADMITS                     NUMBER(33,5),
ADMIT_DAYS                 NUMBER(33,5),
MED_PAID                   NUMBER(33,5),
MED_BAA                    NUMBER(33,5),
MED_MR                     NUMBER(33,5),
DATE_UPDATED        TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
