CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.DOCUMENT_FILE
(
ID                               INT,
USER_ID                          INT,
OWNER_ID                         INT,
CLIENT_ID_IMPORTED               INT,
OWNER_NAME                   VARCHAR,
ACCESS_TYPE                  VARCHAR,
FILENAME                     VARCHAR,
TITLE                        VARCHAR,
CREATED_DATE           TIMESTAMP_NTZ,
MERGE_ID                     VARCHAR,
STORAGE_UUID                 VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
