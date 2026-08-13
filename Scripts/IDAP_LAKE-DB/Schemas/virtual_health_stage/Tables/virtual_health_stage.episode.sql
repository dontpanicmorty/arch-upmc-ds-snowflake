CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.EPISODE
(
ID                                    INT,
CREATED_DATE                TIMESTAMP_NTZ,
UPDATED_DATE                TIMESTAMP_NTZ,
USER_ID                               INT,
CLIENT_ID                             INT,
EPISODE_TYPE                          INT,
EPISODE_ID                        VARCHAR,
STATUS                                INT,
DATE_ENROLLED               TIMESTAMP_NTZ,
DATE_CLOSED                 TIMESTAMP_NTZ,
DESCRIPTION                       VARCHAR,
IS_DRAFT                              INT,
DRAFT_SOURCE_UUID                 VARCHAR,
CLOSED_BY_DISENROLLMENT               INT,
SYSRULES_DISABLE_FLAG                 INT,
MERGE_ID                          VARCHAR,
IS_DELETED                            INT,
UUID                              VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
