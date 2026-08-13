CREATE OR REPLACE TABLE ADL_PROD.INFO_SBA_ONCOLOGY_PHARMACY_CLAIMS
(
MASTER_MEMBER_ID                    VARCHAR,
MEMBER_NBR                          VARCHAR,
PHARMACY_CLAIM_NBR                  VARCHAR,
PRESCRIPTION_NBR                    VARCHAR,
REFILL_CODE                         VARCHAR,
SERVICE_DATE                  TIMESTAMP_NTZ,
PAYMENT_DATE                  TIMESTAMP_NTZ,
PRESCRIPTION_WRITTEN_DATE     TIMESTAMP_NTZ,
NDC_DRUG_CODE                       VARCHAR,
DRUG_NAME_BRAND                     VARCHAR,
MAINTENANCE_DRUG_IND                VARCHAR,
COMPOUND_CODE                       VARCHAR,
DRUG_STRENGTH                       VARCHAR,
DOSAGE_METHOD_CODE                  VARCHAR,
FORMULARY_FLAG                      VARCHAR,
FILL_METHOD_DESC                    VARCHAR,
DRUG_TYPE                           VARCHAR,
BENEFIT_TYPE                        VARCHAR,
SPECIALTY_DRUG_IND                   NUMBER,
RX_PAID                              NUMBER,
INGREDIENT_COST_AMT                  NUMBER,
DISPENSING_FEE_AMT                   NUMBER,
TAX_AMT                              NUMBER,
RX_BAA                               NUMBER,
COPAY_AMT                            NUMBER,
QUANTITY                             NUMBER,
DAYS_SUPPLY                          NUMBER,
LOAD_DATE                     TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
