CREATE OR REPLACE TABLE CMS.DRUG_EVENT_DDPS_RET_TLR_HISTORY(
    RECORD_ID                                       VARCHAR,
    SUBMITTER_ID                                    VARCHAR,
    FILE_ID                                         VARCHAR,
    TLR_BHD_RECORD_TOTAL                            NUMBER,
    TLR_DET_RECORD_TOTAL                            NUMBER,
    TLR_DET_ACCEPTED_RECORD_TOTAL                   NUMBER,
    TLR_DET_INFORMATION_REC_TOTAL                   NUMBER,
    TLR_DET_REJECTED_RECORD_TOTAL                   NUMBER,
    FILLER                                          VARCHAR,
    FILENAME                                        VARCHAR,
    INSERT_DATETIME                                 TIMESTAMP_NTZ
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;