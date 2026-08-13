CREATE OR REPLACE TABLE CM_INTERNAL.IDP_OPIOID
(
HCID                  VARCHAR,
MEM_MONTH             VARCHAR,
MEMBER_NBR            VARCHAR,
RX_DAYS                NUMBER(33,5),
PROP_MONTH_DAYS        NUMBER(33,5),
MAX_DRUGS_PER_DAY      NUMBER(33,5),
MAX_MME                NUMBER(33,5),
AVG_MME                NUMBER(33,5),
MME_0_20               NUMBER(33,5),
MME_20_50              NUMBER(33,5),
MME_50_90              NUMBER(33,5),
MME_GE_90              NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
