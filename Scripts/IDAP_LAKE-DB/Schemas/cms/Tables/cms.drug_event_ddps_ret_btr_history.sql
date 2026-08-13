CREATE OR REPLACE TABLE CMS.DRUG_EVENT_DDPS_RET_BTR_HISTORY(
    RECORD_ID                                       VARCHAR,
    SEQUENCE_NUMBER                                 NUMBER,
    CONTRACT_NUMBER                                 VARCHAR,
    PBP_ID                                          VARCHAR,
    DET_RECORD_TOTAL                                NUMBER,
    DET_ACCEPTED_RECORD_TOTAL                       NUMBER,
    DET_INFORMATIONAL_RECORD_TOTAL                  NUMBER,
    DET_REJECTED_RECORD_TOTAL                       NUMBER,
    FILLER                                          VARCHAR,
    FILENAME                                        VARCHAR,
    INSERT_DATETIME                                 TIMESTAMP_NTZ
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;