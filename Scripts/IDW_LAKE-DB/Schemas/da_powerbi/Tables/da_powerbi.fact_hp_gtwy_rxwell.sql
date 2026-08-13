CREATE OR REPLACE TABLE DA_POWERBI.FACT_HP_GTWY_RXWELL
(
INSERT_DATETIME           TIMESTAMP_NTZ,
LAST_UPDATED_DATETIME     TIMESTAMP_NTZ,
EVENT_TYPE                      VARCHAR,
EVENT_DATE                TIMESTAMP_NTZ,
CORP_ID                         VARCHAR,
GROUP_ID                        VARCHAR,
LINE_OF_BUSINESS                VARCHAR,
MEMBER_NBR                      VARCHAR,
MEMBER_NAME                     VARCHAR,
PROGRAM_NAME                    VARCHAR
)
COMMENT='Created for DA_POWERBI Migration'
;
