CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_VISIT
(
ID                                    INT,
CLIENT_ID                             INT,
OWNER_ID                              INT,
PROVIDER_NAME                     VARCHAR,
CLINICIAN_DESCRIPTOR_ID           VARCHAR,
DATE                        TIMESTAMP_NTZ,
SPECIALTY_ID                          INT,
STATUS                            VARCHAR,
STATUS_DATE_CHANGED         TIMESTAMP_NTZ,
CREATED_DATE                TIMESTAMP_NTZ,
UPDATED_DATE                TIMESTAMP_NTZ,
CPT_CODE                          VARCHAR,
CPT_MODIFIERS                     VARCHAR,
CLINICIAN_DESCRIPTOR              VARCHAR,
CPT_DESCRIPTOR                    VARCHAR,
NOTES                             VARCHAR,
TYPE                                  INT,
ENCOUNTER_ID                          INT,
DESCRIPTION                       VARCHAR,
PLACE_OF_SERVICE                  VARCHAR,
SERVICE_LOCATION_NAME             VARCHAR,
ADT_ID                                INT,
SERVICE_LOCATION_ID                   INT,
UUID                              VARCHAR,
SYSRULES_DISABLE_FLAG                 INT,
MERGE_ID                          VARCHAR,
FOLLOW_UP_ACTIVITY_ID                 INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
