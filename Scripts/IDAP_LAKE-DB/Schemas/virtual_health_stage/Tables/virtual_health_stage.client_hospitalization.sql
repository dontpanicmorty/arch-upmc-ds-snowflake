CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_HOSPITALIZATION
(
ID                                   INT,
CLIENT_ID                            INT,
OWNER_ID                             INT,
REASON                           VARCHAR,
HOSPITALIZATION_DATE       TIMESTAMP_NTZ,
DISCHARGE_DATE             TIMESTAMP_NTZ,
PRESENTLY_HOSPITALIZED           VARCHAR,
NOTES                            VARCHAR,
STATUS                           VARCHAR,
STATUS_DATE_CHANGED        TIMESTAMP_NTZ,
CREATED_DATE               TIMESTAMP_NTZ,
UPDATED_DATE               TIMESTAMP_NTZ,
SOURCE                               INT,
TYPE                                 INT,
STATUS_DISCHARGE                     INT,
ENCOUNTER_ID                         INT,
PLACE_OF_SERVICE                 VARCHAR,
SERVICE_LOCATION_NAME            VARCHAR,
ADT_ID                               INT,
SERVICE_LOCATION_ID                  INT,
UUID                             VARCHAR,
SYSRULES_DISABLE_FLAG                INT,
MERGE_ID                         VARCHAR,
EXTERNAL_ID                      VARCHAR,
SOURCE_SYSTEM                    VARCHAR,
FOLLOW_UP_ACTIVITY_ID                INT,
UNIT_ROOM                        VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
