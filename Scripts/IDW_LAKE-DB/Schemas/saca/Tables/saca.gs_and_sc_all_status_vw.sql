CREATE OR REPLACE TABLE SACA.GS_AND_SC_ALL_STATUS_VW
(
GAINSHARE_ID                         NUMBER,
FILE_NAME                           VARCHAR,
CONTRACT_TYPE                       VARCHAR,
GAINSHARE_STATUS                    VARCHAR,
SHARED_SAVINGS_GROUP_NAME           VARCHAR,
GAINSHARE_NAME                      VARCHAR,
PARTICIPANT_ID                      VARCHAR,
PARTICIPATION_LEVEL                 VARCHAR,
PARTICIPATION_ACTIVE                VARCHAR,
PARTICIPATION_START_DATE      TIMESTAMP_NTZ,
PARTICIPATION_END_DATE        TIMESTAMP_NTZ,
PARTICIPANT_NAME                    VARCHAR,
TIN                                 VARCHAR,
RECORD_LAST_MODIFIED          TIMESTAMP_NTZ,
EPIC_ID                             VARCHAR,
EPIC_NAME                           VARCHAR,
GS_ZONE                             VARCHAR,
GS_ZONE_LVL_2                       VARCHAR,
CUR_REPORT_NAME                     VARCHAR,
CUR_ADDRESS1                        VARCHAR,
CUR_ADDRESS2                        VARCHAR,
CUR_CITY                            VARCHAR,
CUR_STATE                           VARCHAR,
CUR_ZIP                             VARCHAR,
RPT_START_DATE                TIMESTAMP_NTZ,
RPT_END_DATE                  TIMESTAMP_NTZ,
REPORTING_LIMITATIONS               VARCHAR
)
COMMENT='Created for SACA Migration'
;
