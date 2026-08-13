CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CALENDAR
(
ID                              INT,
USER_ID                         INT,
START_RENAMED         TIMESTAMP_NTZ,
END_RENAMED           TIMESTAMP_NTZ,
ALL_DAY                         INT,
TITLE                       VARCHAR,
CREATED_DATE          TIMESTAMP_NTZ,
UPDATED_DATE          TIMESTAMP_NTZ,
DESCRIPTION                 VARCHAR,
CREATOR_ID                      INT,
ORDERHASH                   VARCHAR,
MERGE_ID                    VARCHAR,
DRAFT_SOURCE_UUID           VARCHAR,
INTERACTION_ID                  INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
