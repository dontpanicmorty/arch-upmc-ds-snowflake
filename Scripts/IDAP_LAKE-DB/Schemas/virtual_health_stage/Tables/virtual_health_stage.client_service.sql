CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_SERVICE
(
ID                                  INT,
CLIENT_ID                           INT,
OWNER_ID                            INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
START_DATE                TIMESTAMP_NTZ,
END_DATE                  TIMESTAMP_NTZ,
DESCRIPTION                     VARCHAR,
SERVICE_LOCATION_NAME           VARCHAR,
SERVICE_LOCATION_ID                 INT,
PLACE_OF_SERVICE                VARCHAR,
NOTES                           VARCHAR,
STATUS                          VARCHAR,
STATUS_DATE_CHANGED       TIMESTAMP_NTZ,
UUID                            VARCHAR,
MERGE_ID                        VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
