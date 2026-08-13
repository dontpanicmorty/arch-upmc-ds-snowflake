CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.TASK
(
ID                                       INT,
USER_ID                                  INT,
CLIENT_ID                                INT,
TYPE                                     INT,
PRIORITY                                 INT,
DUEDATE                        TIMESTAMP_NTZ,
DESCRIPTION                          VARCHAR,
STATUS                                   INT,
CREATED_DATE                   TIMESTAMP_NTZ,
UPDATED_DATE                   TIMESTAMP_NTZ,
COMPLETED_DATE                 TIMESTAMP_NTZ,
RELATION_ID                              INT,
LOCKED                                   INT,
COMPLETED_BY_DISENROLLMENT               INT,
EPISODE_ID                               INT,
DRAFT_SOURCE_UUID                    VARCHAR,
COMPLETED_BY_RULE                        INT,
SYSRULES_DISABLE_FLAG                    INT,
MERGE_ID                             VARCHAR,
DUE_TIME_ISSET                           INT,
CALENDAR_EVENT_ID                        INT,
DESCRIPTION_SORTER                   VARCHAR,
DUE_BY_AUTO_UPDATE                       INT,
REFERENCE_DATE_TYPE                      INT,
RELATED_USER_TYPE                        INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
