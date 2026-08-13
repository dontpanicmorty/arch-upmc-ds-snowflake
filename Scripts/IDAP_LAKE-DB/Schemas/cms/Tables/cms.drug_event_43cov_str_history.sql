CREATE OR REPLACE TABLE CMS.DRUG_EVENT_43COV_STR_HISTORY(
    RECORD_ID                                   VARCHAR, 
    SEQUENCE_NUMBER                             NUMBER, 
    CONTRACT_NUMBER                             VARCHAR, 
    FILLER                                      VARCHAR, 
    DRUG_COVERAGE_STATUS_CODE                   VARCHAR, 
    BENEFICIARY_COUNT                           NUMBER,
    CURRENT_MONTH_GDCB_AMOUNT                   FLOAT, 
    CURRENT_MONTH_GDCA_AMOUNT                   FLOAT, 
    CURR_MON_TOTAL_GROSS_DRUG_COST              FLOAT, 
    CURRENT_MONTH_LICS_AMOUNT                   FLOAT, 
    CURRENT_MONTH_CPP_AMOUNT                    FLOAT,
    DET_RECORD_TOTAL                            NUMBER, 
    CURR_MON_P2P_AMT_DUE_ALL_SUB                FLOAT, 
    CURR_MON_SELE_DRUG_SUB_AMT                  FLOAT, 
    FILLER2                                     VARCHAR,
    FILENAME                                    VARCHAR, 
    INSERT_DATETIME                             TIMESTAMP_NTZ, 
    CHD_FILE_ID                                 VARCHAR
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;