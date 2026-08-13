CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.LAB_RESULT
(
ID                                INT,
LAB_ID                            INT,
UNIT_ID                           INT,
FLAG                              INT,
LOINC_NUM                     VARCHAR,
NORMAL_RANGE                  VARCHAR,
TEST_NAME                     VARCHAR,
STATUS                        VARCHAR,
STATUS_DATE_CHANGED     TIMESTAMP_NTZ,
RESULT                        VARCHAR,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
NOTES                         VARCHAR,
UUID                          VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
