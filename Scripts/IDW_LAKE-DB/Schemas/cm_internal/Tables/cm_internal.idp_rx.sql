CREATE OR REPLACE TABLE CM_INTERNAL.IDP_RX
(
HCID                      VARCHAR,
MEM_MONTH                 VARCHAR,
SPECIALTY_CNT              NUMBER(33,5),
RX                         NUMBER(33,5),
RX_DAYS                    NUMBER(33,5),
RX_PAID                    NUMBER(33,5),
RX_BAA                     NUMBER(33,5),
RX_MBR_PAID_AMT            NUMBER(33,5),
DATE_UPDATED        TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
