CREATE OR REPLACE TABLE EDW_RPT.CHC_RATE_CELL
(
MEMBER_NBR                    VARCHAR,
MEMBERSHIP_DATE_YYYYMM        VARCHAR,
NFCE_STATUS                   VARCHAR,
RATE_CELL                     VARCHAR,
PRIVATE_MC                 NUMBER(10),
FFS_FLAG                      VARCHAR,
DUAL_STATUS                   VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
