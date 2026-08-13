CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_PROFILE_CHANGELOG
(
ID                         INT,
CLIENT_ID                  INT,
OWNER_ID                   INT,
TAB                    VARCHAR,
FIELD                  VARCHAR,
OLD_VALUE              VARCHAR,
NEW_VALUE              VARCHAR,
CREATED_DATE     TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
