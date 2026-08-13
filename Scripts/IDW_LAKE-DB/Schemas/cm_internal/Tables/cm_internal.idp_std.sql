CREATE OR REPLACE TABLE CM_INTERNAL.IDP_STD
(
HCID                           VARCHAR,
MEM_MONTH                      VARCHAR,
DATLAG                          NUMBER(33,5),
CURRLAG                         NUMBER(33,5),
PAID_AMOUNT                     NUMBER(33,5),
WORK_LOSS_DAYS                  NUMBER(33,5),
RESTRICTED_DAYS                 NUMBER(33,5),
OPEN_CLAIM                      NUMBER(33,5),
NEW_CLAIM                       NUMBER(33,5),
CLOSED_CLAIM                    NUMBER(33,5),
NEOPLASM                        NUMBER(33,5),
MENTAL_DISORDERS                NUMBER(33,5),
RESPIRATORY_SYSTEM              NUMBER(33,5),
NERVOUS_SENSORY                 NUMBER(33,5),
PREGNANCY                       NUMBER(33,5),
DIGESTIVE_SYSTEM                NUMBER(33,5),
OTHER                           NUMBER(33,5),
GENITOURINARY_SYSTEM            NUMBER(33,5),
MSK_CONNECTIVE                  NUMBER(33,5),
INFECTIOUS_PARASITIC            NUMBER(33,5),
INJURY_POISONING                NUMBER(33,5),
CIRCULATORY_SYSTEM              NUMBER(33,5),
DATE_UPDATED             TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
