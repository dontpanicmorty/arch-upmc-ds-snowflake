CREATE OR REPLACE TABLE CMS.DRUG_EVENT_DDPS_RET_HDR_HISTORY(
    RECORD_ID                                       VARCHAR,
    SUBMITTER_ID                                    VARCHAR,
    FILE_ID                                         VARCHAR,
    TRANS_DATE                                      DATE,
    PROD_TEST_IND                                   VARCHAR,
    DDPS_SYSTEM_DATE                                DATE,
    DDPS_SYSTEM_TIME                                VARCHAR,
    DDPS_REPORT_ID                                  VARCHAR,
    FILLER                                          VARCHAR,
    FILENAME                                        VARCHAR,
    INSERT_DATETIME                                 TIMESTAMP_NTZ
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;