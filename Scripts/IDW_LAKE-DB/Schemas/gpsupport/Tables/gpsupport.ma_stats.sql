CREATE OR REPLACE TABLE GPSUPPORT.MA_STATS
(
PLAN                     VARCHAR,
TYPE                     VARCHAR,
FILE_NAME                VARCHAR,
CLAIM_CNT                 NUMBER,
CHARGE_AMT                NUMBER,
PAID_AMT                  NUMBER,
DATE_SUBMITTED     TIMESTAMP_NTZ,
VENDOR                   VARCHAR
)
COMMENT='Created for GPSUPPORT Migration'
;
