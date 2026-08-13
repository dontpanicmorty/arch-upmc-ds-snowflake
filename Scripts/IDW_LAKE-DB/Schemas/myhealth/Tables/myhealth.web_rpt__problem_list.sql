CREATE OR REPLACE TABLE MYHEALTH.WEB_RPT__PROBLEM_LIST
(
MEMBER_NBR                        VARCHAR,
MASTER_MEMBER_ID                  VARCHAR,
DIAGNOSIS_CODE                    VARCHAR,
DIAGNOSIS_GROUP_CODE              VARCHAR,
PROBLEM_CATEGORY                  VARCHAR,
PROVIDER_NBR                      VARCHAR,
PROVIDER_NAME                     VARCHAR,
PROVIDER_SPECIALTY                VARCHAR,
PROVIDER_SPECIALTY_DESC           VARCHAR,
SERVICE_BEGIN_DATE          TIMESTAMP_NTZ,
RANK_ORDER                         NUMBER,
DATE_FLAG                         VARCHAR,
SOURCE_ID                         VARCHAR,
LOAD_DATE                   TIMESTAMP_NTZ,
UPDATE_DATE                 TIMESTAMP_NTZ,
CLIENT_ID                         VARCHAR,
TPA_ID                            VARCHAR,
TPA_DIV                           VARCHAR,
ICD_VERSION_IND                   VARCHAR,
SUB_CATEGORY                      VARCHAR,
SUB_CATEGORY_DESC                 VARCHAR
)
COMMENT='Created for WEB_RPT Migration'
;