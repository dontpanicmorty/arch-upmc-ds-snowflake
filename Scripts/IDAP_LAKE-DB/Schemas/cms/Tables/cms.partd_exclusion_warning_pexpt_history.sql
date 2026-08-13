CREATE OR REPLACE TABLE CMS.PARTD_EXCLUSION_WARNING_PEXPT_HISTORY
(
    FILENAME                                VARCHAR,
    INSERT_DATETIME                         TIMESTAMP_NTZ,
    RECORD_ID                               VARCHAR,
    SEQUENCE_NUMBER                         NUMBER,
    DDPS_SYSTEM_DATE                        DATE,
    DDPS_SYSTEM_TIME                        VARCHAR,
    FILE_ID                                 VARCHAR,
    CONTRACT_ID                             VARCHAR,
    PBP                                     VARCHAR,
    TOTAL_LICS_AMT                          NUMBER(14,2),
    TOTAL_GDCB_AMT                          NUMBER(14,2),
    TOTAL_GDCA_AMT                          NUMBER(14,2),
    TOTAL_CPP_AMT                           NUMBER(14,2),
    TOTAL_EST_REMUN_AT_POS_AMT              NUMBER(14,2),
    TOTAL_NPP_AMT                           NUMBER(14,2),
    TOTAL_PDE_COUNT                         NUMBER,
    TOTAL_GAP_DISC_AMT                      NUMBER(14,2),
    TOTAL_MANUFAC_DISC_AMT                  NUMBER(14,2),
    TOTAL_SELEC_DRUG_SUB_AMT                NUMBER(14,2),
    TOTAL_PHARM_PRICE_CONCESS_AT_POS        NUMBER(14,2)
);