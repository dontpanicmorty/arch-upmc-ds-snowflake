CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPROVIDER_NOTES
(
ID                                INT,
CLIENT_ID                         INT,
OWNER_ID                          INT,
FORM                          VARCHAR,
ACCESS_TYPE                   VARCHAR,
IS_TEMP                           INT,
IS_ADDENDUM                       INT,
STATUS                        VARCHAR,
STATUS_DATE_CHANGED     TIMESTAMP_NTZ,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
SUBMITTED_DATE          TIMESTAMP_NTZ,
IN_STORAGE                        INT,
MERGE_ID                      VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
