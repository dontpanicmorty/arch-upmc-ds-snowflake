CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_FAMILY_MEMBER_CONDITION
(
ID                                INT,
CLIENT_ID                         INT,
OWNER_ID                          INT,
NAME                          VARCHAR,
RELATION                      VARCHAR,
NOTES                         VARCHAR,
SNOMED_CODE                       INT,
STATUS                        VARCHAR,
STATUS_DATE_CHANGED     TIMESTAMP_NTZ,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
MERGE_ID                      VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
