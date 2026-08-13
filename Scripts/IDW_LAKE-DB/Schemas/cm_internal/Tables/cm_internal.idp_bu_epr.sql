CREATE OR REPLACE TABLE CM_INTERNAL.IDP_BU_EPR
(
BU                           VARCHAR,
DATE_START                    NUMBER(33,5),
DATE_END                      NUMBER(33,5),
EMP_CNT                       NUMBER(33,5),
AVG_EPR_RATING                NUMBER(33,5),
EPR_PROPORTION_UNDER25TH      NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
