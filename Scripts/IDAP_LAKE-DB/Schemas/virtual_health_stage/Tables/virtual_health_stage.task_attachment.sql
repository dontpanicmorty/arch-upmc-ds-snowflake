CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.TASK_ATTACHMENT
(
ID                                             INT,
TASK_ID                                        INT,
FILENAME                                   VARCHAR,
TITLE                                      VARCHAR,
CREATED_DATE                         TIMESTAMP_NTZ,
UPDATED_DATE                         TIMESTAMP_NTZ,
OWNER_ID                                       INT,
DRAFT_UUID                                 VARCHAR,
DOCUMENT_UUID                              VARCHAR,
COPIED_FROM_EXTERNAL_DOCUMENT_ID               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
