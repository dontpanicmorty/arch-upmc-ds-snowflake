CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_CONDITION
(
ID                                  INT,
CLIENT_ID                           INT,
OWNER_ID                            INT,
PRIMARY_DIAGNOSIS                   INT,
ICD9_NAME                       VARCHAR,
ICD10_NAME                      VARCHAR,
DIAGNOSIS_DATE            TIMESTAMP_NTZ,
PRESENT_DAY                     VARCHAR,
TREATMENT                       VARCHAR,
NOTES                           VARCHAR,
ICD9_CODE                       VARCHAR,
ICD10_CODE                      VARCHAR,
SNOMED_CID                      VARCHAR,
STATUS                          VARCHAR,
STATUS_DATE_CHANGED       TIMESTAMP_NTZ,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
ENCOUNTER_ID                        INT,
CLIENT_SERVICE_ID                   INT,
ADT_ID                              INT,
UUID                            VARCHAR,
SYSRULES_DISABLE_FLAG               INT,
MERGE_ID                        VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
