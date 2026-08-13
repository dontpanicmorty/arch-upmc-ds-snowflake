CREATE OR REPLACE TABLE EDW_USR_TAB.PARTDEXCLUSWARN_PEXBT_VW
(
RECORD_ID                                  VARCHAR,
DDPS_SYSTEM_DATE                     TIMESTAMP_NTZ,
DDPS_SYSTEM_TIME                           VARCHAR,
FILE_ID                                    VARCHAR,
RECON_BENEFIT_YEAR                         VARCHAR,
RECON_NUM                                  VARCHAR,
TOTAL_LICS_AMT                              NUMBER,
TOTAL_GDCB_AMT                              NUMBER,
TOTAL_GDCA_AMT                              NUMBER,
TOTAL_CPP_AMT                               NUMBER,
TOTAL_EST_REBATE_POS                        NUMBER,
TOTAL_NPP_AMT                               NUMBER,
TOTAL_PDE_COUNT                            VARCHAR,
TOTAL_EST_REMUN_AT_POS_AMT                  NUMBER,
TOTAL_GAP_DISC_AMT                          NUMBER,
TOTAL_MANUFAC_DISC_AMT                      NUMBER,
TOTAL_SELEC_DRUG_SUB_AMT                    NUMBER,
TOTAL_PHARM_PRICE_CONCESS_AT_POS            NUMBER,
FILE_NAME                                  VARCHAR,
LOAD_DATE                            TIMESTAMP_NTZ
)
COMMENT='Created for EDW_USR_TAB Migration'
;
