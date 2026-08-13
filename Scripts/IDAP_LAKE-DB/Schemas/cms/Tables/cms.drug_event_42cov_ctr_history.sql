CREATE OR REPLACE TABLE CMS.DRUG_EVENT_42COV_CTR_HISTORY(
    RECORD_ID                                   VARCHAR,
    SEQUENCE_NUMBER                             NUMBER,
    CONTRACT_NUMBER                             VARCHAR,
    DRUG_COVERAGE_STATUS_CODE                   VARCHAR,
    BENEFICIARY_COUNT                           NUMBER,
    NET_GDCB                                    FLOAT,
    NET_GDCA                                    FLOAT,
    NET_TOTAL_GROSS_DRUG_COST                   FLOAT,
    NET_LICS_AMOUNT                             FLOAT,
    NET_CPP_AMOUNT                              FLOAT,
    DET_RECORD_TOTAL                            NUMBER,
    P2P_AMT_DUE_ALL_SUBMIT_CON                  FLOAT,
    NET_SELE_DRUG_SUB_AMT                       FLOAT,
    FILLER                                      VARCHAR,
    FILENAME                                    VARCHAR,
    INSERT_DATETIME                             TIMESTAMP_NTZ
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;