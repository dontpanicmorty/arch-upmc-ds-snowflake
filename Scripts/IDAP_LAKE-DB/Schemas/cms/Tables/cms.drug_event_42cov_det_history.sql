CREATE OR REPLACE TABLE CMS.DRUG_EVENT_42COV_DET_HISTORY(
    RECORD_ID                                   VARCHAR, 
    SEQUENCE_NUMBER                             NUMBER, 
    DRUG_COVERAGE_STATUS_CODE                   VARCHAR, 
    CURRENT_CMS_HICN                            VARCHAR, 
    LAST_SUBMITTED_HICN                         VARCHAR, 
    NET_GDCB                                    FLOAT, 
    NET_GDCA                                    FLOAT, 
    NET_TOTAL_GROSS_DRUG_COST                   FLOAT, 
    NET_LICS_AMOUNT                             FLOAT, 
    NET_CPP_AMOUNT                              FLOAT, 
    P2P_CONTRACT                                VARCHAR, 
    P2P_AMOUNT                                  VARCHAR, 
    NET_SELE_DRUG_SUB_AMT                       FLOAT, 
    FILLER                                      VARCHAR, 
    FILENAME                                    VARCHAR, 
    INSERT_DATETIME                             TIMESTAMP_NTZ, 
    CURRENT_CMS_MBI                             VARCHAR, 
    LAST_SUBMITTED_MBI                          VARCHAR
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;