CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_HABIT
(
ID                                INT,
CLIENT_ID                         INT,
OWNER_ID                          INT,
NAME                          VARCHAR,
START_YEAR                        INT,
END_YEAR                          INT,
FREQUENCY_OF_USE              VARCHAR,
AMOUNT_OF_USE                 VARCHAR,
NOTES                         VARCHAR,
PRESENT_DAY                       INT,
STATUS                        VARCHAR,
STATUS_DATE_CHANGED     TIMESTAMP_NTZ,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
MERGE_ID                      VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
