CREATE OR REPLACE TABLE CM_INTERNAL.IDP_GH
(
HCID                   VARCHAR,
SVC_DATE         TIMESTAMP_NTZ,
MED                     NUMBER(33,5),
RX                      NUMBER(33,5),
MED_PAID                NUMBER(33,5),
RX_PAID                 NUMBER(33,5),
GH_PAID                 NUMBER(33,5),
DATE_UPDATED     TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
