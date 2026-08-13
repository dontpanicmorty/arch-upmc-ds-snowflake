CREATE OR REPLACE TABLE ADL_PROD.INFO_EDM_MBR_RX_COVERAGE
(
EDM_SOURCE                       VARCHAR,
EDM_TYPE                         VARCHAR,
MMI                              VARCHAR,
MEMBER_NBR                       VARCHAR,
MEMBERSHIP_DATE_YYYYMM           VARCHAR,
RX_COVERAGE                       NUMBER,
LOAD_DATE                  TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
