CREATE OR REPLACE TABLE HPANALYTICS.HP_ANYWHERECARE
(
MEMBER_NBR                      VARCHAR,
PATIENT_LAST_NAME               VARCHAR,
PATIENT_FIRST_NAME              VARCHAR,
PATIENT_GENDER_CODE             VARCHAR,
CORPORATION_ID                  VARCHAR,
GROUP_ID                        VARCHAR,
DIVISION_ID                     VARCHAR,
BUSINESS_INSURED_TYPE           VARCHAR,
PLAN_NBR                        VARCHAR,
CONVVSCONT                      VARCHAR,
ENC_OPENED_TIME               TIMESTAMP,
WAIT_DURATION_MIN_SEC           VARCHAR,
VISIT_DURATION_MIN_SEC          VARCHAR,
CPT4_CODE                       VARCHAR,
ICD_DX_CODE                     VARCHAR,
ICD_DX_DESCR                    VARCHAR,
ICD9_CODE                       VARCHAR,
ICD9_DESCR                      VARCHAR,
ICD10_CODE                      VARCHAR,
ICD10_DESCR                     VARCHAR,
NDC_CODE                        VARCHAR,
PROVIDER_ID                     VARCHAR,
PROVIDER_NPI                    VARCHAR,
VISIT_STATUS                    VARCHAR,
VISIT_TOPIC                     VARCHAR,
CHARGED_VISIT                    NUMBER(33,5),
COMPLETED_VISIT                  NUMBER(33,5),
MHW_AWC_FLAG                    VARCHAR
)
COMMENT='Created for HPANALYTICS Migration'
;
