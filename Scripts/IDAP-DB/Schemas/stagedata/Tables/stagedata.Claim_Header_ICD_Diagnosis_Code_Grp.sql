CREATE OR REPLACE TRANSIENT TABLE STAGEDATA.CLAIM_HEADER_ICD_DIAGNOSIS_CODE_GRP
(
    CLAIM_HEADER_ICD_DIAGNOSIS_CODE_KEY VARCHAR NOT NULL COMMENT 'This is either the stagedata.claim_header.claim_header_key or the hubdata.hub_claim.hub_claim_hkey',
    CODE_VALUE VARCHAR NOT NULL,
    LOAD_TIMESTAMP TIMESTAMP_TZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CONSTRAINT PK_CLAIM_HEADER_ICD_DIAGNOSIS_CODE_GRP PRIMARY KEY (CLAIM_HEADER_ICD_DIAGNOSIS_CODE_KEY),
    CONSTRAINT UK_CLAIM_HEADER_ICD_DIAGNOSIS_CODE_GRP UNIQUE (CLAIM_HEADER_ICD_DIAGNOSIS_CODE_KEY)
) COMMENT = 'This is a transient work table that holds the concatenated ICD diagnosis code grouping for each claimHeader it is sourced from stagedata.claim_header_icd_diagnosis_code'
;