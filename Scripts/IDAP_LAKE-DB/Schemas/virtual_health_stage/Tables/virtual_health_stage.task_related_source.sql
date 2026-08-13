CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.TASK_RELATED_SOURCE
(
ID                                 INT,
TASK_ID                            INT,
SOURCE_ID                          INT,
CLIENT_ID                          INT,
SOURCE_TYPE                    VARCHAR,
CREATED_DATE             TIMESTAMP_NTZ,
REFERENCE_FOREIGN_ID               INT,
MERGE_ID                       VARCHAR,
STATUS                             INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
