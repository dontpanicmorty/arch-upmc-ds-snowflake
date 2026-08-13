CREATE OR REPLACE TABLE GPSUPPORT.FB_UPMC_TRAD_INST_DTL
(
RECORD_TYPE           VARCHAR,
MCO                   VARCHAR,
ICN                   VARCHAR,
PROC_CODE             VARCHAR,
REV_CODE              VARCHAR,
SOURCE                VARCHAR,
BEGIN_DOS             VARCHAR,
END_DOS               VARCHAR,
DETAIL_NUM            VARCHAR,
FLAG_VOID             VARCHAR,
FLAG_ADJ              VARCHAR,
FLAG_ACCEPT           VARCHAR,
LOAD_DATE       TIMESTAMP_NTZ
)
COMMENT='Created for GPSUPPORT Migration'
;
