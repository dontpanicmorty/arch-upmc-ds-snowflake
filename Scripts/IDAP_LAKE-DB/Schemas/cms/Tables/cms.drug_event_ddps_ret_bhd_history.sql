CREATE OR REPLACE TABLE CMS.DRUG_EVENT_DDPS_RET_BHD_HISTORY(
    RECORD_ID                                       VARCHAR,
    SEQUENCE_NUMBER                                 NUMBER,
    CONTRACT_NUMBER                                 VARCHAR,
    PBP_ID                                          VARCHAR,
    DDPS_SYSTEM_DATE                                DATE,
    DDPS_SYSTEM_TIME                                VARCHAR,
    DDPS_REPORT_ID                                  VARCHAR,
    FILLER                                          VARCHAR,
    FILENAME                                        VARCHAR,
    INSERT_DATETIME                                 TIMESTAMP_NTZ
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;