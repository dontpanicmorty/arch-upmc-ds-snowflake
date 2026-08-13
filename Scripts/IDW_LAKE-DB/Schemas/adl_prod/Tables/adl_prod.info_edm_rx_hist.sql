CREATE OR REPLACE TABLE ADL_PROD.INFO_EDM_RX_HIST
(
EDM_SOURCE                          VARCHAR,
EDM_TYPE                            VARCHAR,
MMI                                 VARCHAR,
ESI_CLAIM_NBR                       VARCHAR,
NDC_DRUG_CODE                       VARCHAR,
FILL_DATE                     TIMESTAMP_NTZ,
ORDER_DATE                    TIMESTAMP_NTZ,
NBR_REFILLS_ORDER                    NUMBER,
ORDER_SRC                           VARCHAR,
REVERSAL_DATE                 TIMESTAMP_NTZ,
DRUG_NAME_GENERIC                   VARCHAR,
DRUG_NAME_BRAND                     VARCHAR,
DRUG_LABEL                          VARCHAR,
DRUG_STRENGTH                       VARCHAR,
DRUG_ROUTE                          VARCHAR,
FORMULARY_FLAG                      VARCHAR,
DISPENSE_AS_WRITTEN                 VARCHAR,
METRIC_QUANTITY                      NUMBER,
DAY_SUPPLY                           NUMBER,
NEW_REFILL_CODE                      NUMBER,
GCN_CODE                            VARCHAR,
THER_CLASS_CODE_AHFS                VARCHAR,
THER_CLASS_CODE_AHFS_DESC           VARCHAR,
PHARM_LOAD_DATE               TIMESTAMP_NTZ,
LOAD_DATE                     TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
