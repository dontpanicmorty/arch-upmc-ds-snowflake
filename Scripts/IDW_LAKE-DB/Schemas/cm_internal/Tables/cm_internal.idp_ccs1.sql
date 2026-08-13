CREATE OR REPLACE TABLE CM_INTERNAL.IDP_CCS1
(
HCID                            VARCHAR,
MEM_MONTH                       VARCHAR,
DATLAG                           NUMBER(33,5),
CURRLAG                          NUMBER(33,5),
BLOOD                            NUMBER(33,5),
MENTAL                           NUMBER(33,5),
INFECTIOUS_PARASITIC             NUMBER(33,5),
PREGNANCY                        NUMBER(33,5),
CIRCULATORY                      NUMBER(33,5),
INTEGUMENTARY                    NUMBER(33,5),
UNCLASSIFIED                     NUMBER(33,5),
NERVOUS                          NUMBER(33,5),
URINARY                          NUMBER(33,5),
ENDOCRINE                        NUMBER(33,5),
CONGENITAL_ANOMALIES             NUMBER(33,5),
DIGESTIVE                        NUMBER(33,5),
ILL_DEFINED                      NUMBER(33,5),
INJURY_POISONING                 NUMBER(33,5),
RESPIRATORY                      NUMBER(33,5),
CANCER                           NUMBER(33,5),
MSK_CONNECTIVE_TISSUE            NUMBER(33,5),
ANY_SVC                          NUMBER(33,5),
DATE_UPDATED              TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
