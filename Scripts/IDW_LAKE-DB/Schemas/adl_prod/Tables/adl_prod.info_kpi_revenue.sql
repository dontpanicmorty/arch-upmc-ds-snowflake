CREATE OR REPLACE TABLE ADL_PROD.INFO_KPI_REVENUE
(
RUN_ID                           VARCHAR,
KPI_MASTER_ID                    VARCHAR,
MEMBER_NBR                       VARCHAR,
MASTER_MEMBER_ID                 VARCHAR,
YYYYMM                           VARCHAR,
LOB                              VARCHAR,
TOTAL_REVENUE                     NUMBER,
TOTAL_REVENUE_ADJUSTED            NUMBER,
RECIPIENT_GROUP_NBR              VARCHAR,
HCC_SCORE                         NUMBER,
MA_PMT_PRI                        NUMBER,
PD_RISK_PMT_PRI                   NUMBER,
LIPS_PRI                          NUMBER,
MED_PREM_PRI                      NUMBER,
MBR_PREM_PRI                      NUMBER,
PDE_REPORT_GAP_DIS                NUMBER,
PDE_LICS                          NUMBER,
PDE_GDCA                          NUMBER,
TOTAL_RX_REBATES                  NUMBER
)
COMMENT='Created for ADL_PROD Migration'
;
