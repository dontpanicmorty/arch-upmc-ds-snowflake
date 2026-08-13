CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.EPISODE_REFERRAL
(
ID                                  INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
USER_ID                             INT,
EPISODE_ID                          INT,
SOURCE                              INT,
TYPE                                INT,
DESCRIPTION                     VARCHAR,
IS_DRAFT                            INT,
DRAFT_SOURCE_UUID               VARCHAR,
INTERACTION_ID                      INT,
SYSRULES_DISABLE_FLAG               INT,
MERGE_ID                        VARCHAR,
DATE_CLOSED               TIMESTAMP_NTZ,
CLOSE_REASON                        INT,
IS_DELETED                          INT,
UUID                            VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
