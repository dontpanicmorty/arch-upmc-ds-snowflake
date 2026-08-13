CREATE OR REPLACE TABLE EDW_USR_TAB.FMS_FORMULARY_NDC
(
MED_ID                                 NUMBER,
FORM_ID                                NUMBER,
TIER                                   NUMBER,
EFF_DATE                        TIMESTAMP_NTZ,
TERM_DATE                       TIMESTAMP_NTZ,
PRIOR_AUTH_IND                        VARCHAR,
STEP_THERAPY_IND                      VARCHAR,
QUANTITY_LIMIT_IND                    VARCHAR,
QUANTITY_LIMIT_AMT                     NUMBER,
QUANTITY_LIMIT_DAYS                    NUMBER,
THERAPEUTIC_DUPLICATION_IND           VARCHAR,
AGE_LIMIT_IND                         VARCHAR,
AGE_LIMIT                             VARCHAR,
NDC                                   VARCHAR
)
COMMENT='Created for EDW_USR_TAB Migration'
;
