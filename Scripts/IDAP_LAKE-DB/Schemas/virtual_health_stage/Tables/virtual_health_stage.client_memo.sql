CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_MEMO
(
ID                                  INT,
CLIENT_ID                           INT,
OWNER_ID                            INT,
MEMO                            VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
LINKS_DATA                      VARCHAR,
SOURCE_TYPE                     VARCHAR,
SOURCE_TYPE_COMMENT             VARCHAR,
SOURCE_ID                           INT,
SYSRULES_DISABLE_FLAG               INT,
MERGE_ID                        VARCHAR,
IS_DELETED                          INT,
UUID                            VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
