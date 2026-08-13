CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_PROCEDURE
(
ID                                    INT,
CLIENT_ID                             INT,
OWNER_ID                              INT,
CLINICIAN_DESCRIPTOR_ID           VARCHAR,
SURGERY_DATE                TIMESTAMP_NTZ,
SERVICE_LOCATION_ID                   INT,
OPERATIVE_REPORT                  VARCHAR,
STATUS                            VARCHAR,
STATUS_DATE_CHANGED         TIMESTAMP_NTZ,
CREATED_DATE                TIMESTAMP_NTZ,
UPDATED_DATE                TIMESTAMP_NTZ,
CODETYPE                          VARCHAR,
CPT_CODE                          VARCHAR,
CPT_MODIFIERS                     VARCHAR,
CPT_DESCRIPTOR                    VARCHAR,
CLINICIAN_DESCRIPTOR              VARCHAR,
ICD10_CODE                        VARCHAR,
ICD10_DESCRIPTION                 VARCHAR,
NOTES                             VARCHAR,
ENCOUNTER_ID                          INT,
PLACE_OF_SERVICE                  VARCHAR,
CLIENT_SERVICE_ID                     INT,
ADT_ID                                INT,
PROVIDER_NAME                     VARCHAR,
PROVIDER_ID                           INT,
SERVICE_LOCATION_NAME             VARCHAR,
UUID                              VARCHAR,
MERGE_ID                          VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
