CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ASSESSMENT_FORM
(
ID                                 INT,
CODE                           VARCHAR,
TITLE                          VARCHAR,
DATA                           VARCHAR,
DATA_CONTAINER                 VARCHAR,
DESCRIPTION                    VARCHAR,
TYPE                           VARCHAR,
LOCK_TIME                          INT,
CATEGORY                       VARCHAR,
LOB                            VARCHAR,
PLAN_ID                        VARCHAR,
USER_ID                            INT,
PRINT_ORIENTATION              VARCHAR,
CREATED_DATE             TIMESTAMP_NTZ,
UPDATED_DATE             TIMESTAMP_NTZ,
COLUMN_LAYOUT                      INT,
JSWRAPPER_FILE                 VARCHAR,
CM_ENABLED                         INT,
CP_ENABLED                         INT,
CR_CL_ENABLED                      INT,
NUM_VISIBLE                        INT,
DELETED                            INT,
IS_DRAFT                           INT,
CSSWRAPPER_FILE                VARCHAR,
COLLAPSE_SECTIONS                  INT,
QUICK_SECTION_ACCESS               INT,
PLAN_FILTERS                   VARCHAR,
IS_PRINT_LOGO                      INT,
ENABLE_REFRESH                     INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
