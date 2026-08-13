CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.TASK_MEMO
(
ID                         INT,
TASK_ID                    INT,
CLIENT_ID                  INT,
OWNER_ID                   INT,
MEMO                   VARCHAR,
CREATED_DATE     TIMESTAMP_NTZ,
UPDATED_DATE     TIMESTAMP_NTZ,
LINKS_DATA             VARCHAR,
MERGE_ID               VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
