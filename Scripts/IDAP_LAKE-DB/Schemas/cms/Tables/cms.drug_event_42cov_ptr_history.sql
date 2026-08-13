CREATE OR REPLACE TABLE CMS.DRUG_EVENT_42COV_PTR_HISTORY(
    RECORD_ID                                   VARCHAR, 
    SEQUENCE_NUMBER                             NUMBER, 
    CONTRACT_NUMBER                             VARCHAR, 
    PBP_ID                                      VARCHAR, 
    DRUG_COVERAGE_STATUS_CODE                   VARCHAR, 
    BENEFICIARY_COUNT                           NUMBER, 
    NET_GDCB_AMOUNT                             FLOAT, 
    NET_GDCA_AMOUNT                             FLOAT, 
    NET_TOTAL_GROSS_DRUG_COST                   FLOAT, 
    NET_LICS_AMOUNT                             FLOAT, 
    NET_CPP_AMOUNT                              FLOAT, 
    DET_RECORD_TOTAL                            NUMBER, 
    P2P_AMT_DUE_ALL_SUBMIT_CON                  FLOAT, 
    NET_SELE_DRUG_SUB_AMT                       FLOAT, 
    FILLER                                      VARCHAR,
    FILENAME                                    VARCHAR, 
    INSERT_DATETIME                             TIMESTAMP_NTZ, 
    CHD_FILE_ID                                 VARCHAR
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;