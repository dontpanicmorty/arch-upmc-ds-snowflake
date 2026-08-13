CREATE OR REPLACE TABLE DA_POWERBI.OHP_DIM_DATE
(
YYYYMM                     VARCHAR,
CY                         VARCHAR,
DT_RANK                     NUMBER(33,5),
DT_LABEL_FULL              VARCHAR,
DT_LABEL_PARTIAL           VARCHAR,
DAY_DATE             TIMESTAMP_NTZ
)
COMMENT='Created for DA_POWERBI Migration'
;
