CREATE OR REPLACE TABLE CM_INTERNAL.IDP_INTEGRATED_M2
(
HCID                   VARCHAR,
MONTH                   NUMBER(33,5),
MED_PAID                NUMBER(33,5),
RX_PAID                 NUMBER(33,5),
GH_PAID                 NUMBER(33,5),
WC_PAID                 NUMBER(33,5),
STD_PAID                NUMBER(33,5),
UNPLANNED_PAID          NUMBER(33,5),
WC_DAYS                 NUMBER(33,5),
STD_DAYS                NUMBER(33,5),
LEAVE_DAYS              NUMBER(33,5),
UNPLANNED_DAYS          NUMBER(33,5),
LOST_WORK_DAYS          NUMBER(33,5),
PROGRAM_PAID            NUMBER(33,5),
PRODUCTIVITY_PAID       NUMBER(33,5),
INTEGRATED_COST         NUMBER(33,5),
AVG_WAGE                NUMBER(33,5),
TENURE                  NUMBER(33,5),
CUMULATIVE_PERCENT      NUMBER(33,5),
DECILE                  NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
