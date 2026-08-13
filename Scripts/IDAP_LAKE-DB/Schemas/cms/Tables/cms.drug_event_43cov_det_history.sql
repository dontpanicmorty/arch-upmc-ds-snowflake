CREATE OR REPLACE TABLE CMS.DRUG_EVENT_43COV_DET_HISTORY(
    RECORD_ID                                   VARCHAR, 
    SEQUENCE_NUMBER                             NUMBER, 
    DRUG_COVERAGE_STATUS_CODE                   VARCHAR, 
    CURRENT_CMS_HICN                            VARCHAR, 
    LAST_SUBMITTED_HICN                         VARCHAR, 
    CURRENT_MONTH_GDCB                          FLOAT, 
    CURRENT_MONTH_GDCA                          FLOAT, 
    CURR_MON_TOTAL_GROSS_DRUG_COST              FLOAT, 
    CURRENT_MONTH_LICS_AMOUNT                   FLOAT, 
    CURRENT_MONTH_CPP_AMOUNT                    FLOAT, 
    P2P_CONTRACT                                VARCHAR, 
    P2P_AMOUNT                                  VARCHAR, 
    CURR_MON_SELE_DRUG_SUB_AMT                  FLOAT, 
    FILLER                                      VARCHAR,
    INSERT_DATETIME                             TIMESTAMP_NTZ,     
    FILENAME                                    VARCHAR, 
    CURRENT_CMS_MBI                             VARCHAR, 
    LAST_SUBMITTED_MBI                          VARCHAR
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;