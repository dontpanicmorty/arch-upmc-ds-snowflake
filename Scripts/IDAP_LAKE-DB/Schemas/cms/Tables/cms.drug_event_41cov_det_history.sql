CREATE OR REPLACE TABLE CMS.DRUG_EVENT_41COV_DET_HISTORY (
    RECORD_ID                           VARCHAR,
    SEQUENCE_NUMBER                     NUMBER,
    DRUG_COVERAGE_STATUS_CODE           VARCHAR,
    CURRENT_CMS_HICN                    VARCHAR, 
    LAST_SUBMITTED_HICN                 VARCHAR,
    LAST_SUBMITTED_CARDHOLDER_ID        VARCHAR,
    CURR_MON_GDCB                       FLOAT, 
    CURR_MON_GDCA                       FLOAT, 
    CURR_MON_TOTAL_GROSS_DRUG_COST      FLOAT, 
    CURR_MON_LICS_AMOUNT                FLOAT, 
    CURR_MON_CPP_AMOUNT                 FLOAT, 
    CURR_MON_P2P_AMOUNT                 FLOAT, 
    CURR_MON_SELE_DRUG_SUB_AMT          FLOAT,
    FILLER                              VARCHAR,
    FILENAME                            VARCHAR,
    INSERT_DATETIME                     TIMESTAMP_NTZ,
    CURRENT_CMS_MBI                     VARCHAR, 
    LAST_SUBMITTED_MBI                  VARCHAR
)
COMMENT = 'Historical data from Oracle through the end of 2025'
;