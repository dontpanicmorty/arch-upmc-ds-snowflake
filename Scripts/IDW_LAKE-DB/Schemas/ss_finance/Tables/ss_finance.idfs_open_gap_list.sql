CREATE OR REPLACE TABLE SS_FINANCE.IDFS_OPEN_GAP_LIST
(
LOB_QUALITY                       VARCHAR,
EMPI_ID                           VARCHAR,
MEMBER_NBR                        VARCHAR,
GAINSHARE_NAME                    VARCHAR,
PROVIDER_ID_FINAL                 VARCHAR,
PROVIDER_NPI_FINAL                VARCHAR,
PROVIDER_NAME_FINAL               VARCHAR,
SUB_MEASURE_ID                    VARCHAR,
SUB_MEASURE_DESC                  VARCHAR,
PRIORITY_FLAG                      NUMBER,
ADDITIONAL_MEASURE_INFO           VARCHAR,
LOAD_DATE                   TIMESTAMP_NTZ
)
COMMENT='Created for SS_FINANCE Migration'
;
