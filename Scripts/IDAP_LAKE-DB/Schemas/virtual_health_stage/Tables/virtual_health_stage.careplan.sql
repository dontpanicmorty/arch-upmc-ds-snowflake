CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN
(
ID                             INT,
CLIENT_ID                      INT,
SIGNUSER_ID                    INT,
PCP_NAME                   VARCHAR,
PCP_PHONE                  VARCHAR,
PCP_FAX                    VARCHAR,
CC_NAME                    VARCHAR,
CC_PHONE                   VARCHAR,
BHS_NAME                   VARCHAR,
BHS_PHONE                  VARCHAR,
IS_TEMP                        INT,
CREATED_DATE         TIMESTAMP_NTZ,
UPDATE_DATE          TIMESTAMP_NTZ,
RECERTIF_DATE              VARCHAR,
SHOW_MEDICATIONS               INT,
HEADER_EXTRA               VARCHAR,
IS_OUT_OF_CARE                 INT,
NOTES                      VARCHAR,
MERGE_ID                   VARCHAR,
IS_DRAFT                       INT,
LAST_SAVED_DRAFT     TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
