CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.DOCUMENT_REPORT
(
ID                         INT,
OWNER_ID                   INT,
CLIENT_ID                  INT,
ACCESS_TYPE            VARCHAR,
TITLE                  VARCHAR,
DESCRIPTION            VARCHAR,
FILENAME               VARCHAR,
CREATED_DATE     TIMESTAMP_NTZ,
MERGE_ID               VARCHAR,
STORAGE_UUID           VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
