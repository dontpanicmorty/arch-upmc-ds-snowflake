CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.EXTERNAL_DOC_FILE
(
ID                         INT,
CLIENT_ID                  INT,
OWNER_ID                   INT,
ACCESS_TYPE            VARCHAR,
FILENAME               VARCHAR,
TITLE                  VARCHAR,
CREATED_DATE     TIMESTAMP_NTZ,
NOTE_ID                    INT,
MERGE_ID               VARCHAR,
STORAGE_UUID           VARCHAR,
TYPE                       INT,
COMMENTS               VARCHAR,
SOURCE_ID              VARCHAR,
UPDATED_DATE     TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
