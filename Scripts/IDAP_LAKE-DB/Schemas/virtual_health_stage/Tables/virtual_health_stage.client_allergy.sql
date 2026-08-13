CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_ALLERGY
(
ID                                INT,
CLIENT_ID                         INT,
OWNER_ID                          INT,
NO_KNOWN_ALLERGIES                INT,
ALLERGEN_TYPE                     INT,
NAME                          VARCHAR,
CONCEPTID                     VARCHAR,
DIAGNOSTIC_DATE         TIMESTAMP_NTZ,
ADVERSE_EVENT_DATE      TIMESTAMP_NTZ,
STATUS                        VARCHAR,
STATUS_DATE_CHANGED     TIMESTAMP_NTZ,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
DESCRIPTION                   VARCHAR,
NOTES                         VARCHAR,
ENCOUNTER_ID                      INT,
CLIENT_SERVICE_ID                 INT,
MERGE_ID                      VARCHAR,
EXTERNAL_ID                   VARCHAR,
SOURCE                        VARCHAR,
UUID                          VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
