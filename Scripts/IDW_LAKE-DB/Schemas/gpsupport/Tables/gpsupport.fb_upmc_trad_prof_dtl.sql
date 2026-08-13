CREATE OR REPLACE TABLE GPSUPPORT.FB_UPMC_TRAD_PROF_DTL
(
RECORD_TYPE            VARCHAR,
MCO                    VARCHAR,
ICN                    VARCHAR,
PROC_CODE              VARCHAR,
SOURCE                 VARCHAR,
BEGIN_DOS              VARCHAR,
END_DOS                VARCHAR,
MODIFIER_1             VARCHAR,
MODIFIER_2             VARCHAR,
DETAIL_NUM             VARCHAR,
FLAG_VOID              VARCHAR,
FLAG_ADJ               VARCHAR,
FLAG_ACCEPT            VARCHAR,
DTL_MCO_PAID            NUMBER,
LOAD_DATE        TIMESTAMP_NTZ
)
COMMENT='Created for GPSUPPORT Migration'
;
