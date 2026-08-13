CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ASSESSMENT_DATA
(
ID                                   INT,
USER_ID                              INT,
CLIENT_ID                            INT,
FORM_ID                              INT,
LAYOUT_MD5                       VARCHAR,
FORM_CODE                        VARCHAR,
TYPE                             VARCHAR,
CATEGORY                         VARCHAR,
ANSWERS                          VARCHAR,
STATUS                               INT,
ACCESS                               INT,
CREATED_DATE               TIMESTAMP_NTZ,
UPDATED_DATE               TIMESTAMP_NTZ,
SUBMITTED_DATE             TIMESTAMP_NTZ,
COLUMN_LAYOUT                        INT,
FORMAT_VERSION                       INT,
ASM_DATE                   TIMESTAMP_NTZ,
IN_ELASTIC                           INT,
JSWRAPPER_FILE                   VARCHAR,
DELETED                              INT,
CSSWRAPPER_FILE                  VARCHAR,
IMPORT_HASH                      VARCHAR,
CLIENT_INFO                      VARCHAR,
ORIGIN_ID                            INT,
SYSRULES_DISABLE_FLAG                INT,
MERGE_ID                         VARCHAR,
CREATED_BY_INTEGRATION           VARCHAR,
UUID                             VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
