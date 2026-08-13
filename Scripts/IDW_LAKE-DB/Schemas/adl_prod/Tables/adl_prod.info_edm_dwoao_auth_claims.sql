CREATE OR REPLACE TABLE ADL_PROD.INFO_EDM_DWOAO_AUTH_CLAIMS
(
CLAIM_NBR                            VARCHAR,
CLAIM_SEQ                            VARCHAR,
AUTH_NBR                             VARCHAR,
AUTH_DATE                      TIMESTAMP_NTZ,
AUTH_STATUS                          VARCHAR,
AUTH_PROCEDURE_CODE                  VARCHAR,
ENCOUNTER_REASON                     VARCHAR,
AUTH_BENEFIT_CATEGORY_CODE           VARCHAR,
SPECIFIC_DATE_OF_SERVICE       TIMESTAMP_NTZ,
LOAD_DATE                      TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
