CREATE OR REPLACE TABLE GPSUPPORT.FB_UPMC_TRAD_RX_DTL
(
RECORD_TYPE           VARCHAR,
MCO                   VARCHAR,
ICN                   VARCHAR,
NDC                   VARCHAR,
SOURCE                VARCHAR,
DETAIL_NUM            VARCHAR,
FLAG_VOID             VARCHAR,
FLAG_ADJ              VARCHAR,
FLAG_ACCEPT           VARCHAR,
LOAD_DATE       TIMESTAMP_NTZ
)
COMMENT='Created for GPSUPPORT Migration'
;
