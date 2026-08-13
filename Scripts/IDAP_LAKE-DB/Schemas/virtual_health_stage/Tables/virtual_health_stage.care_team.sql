CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CARE_TEAM
(
ID                         INT,
CLIENT_ID                  INT,
MEMBER_ID                  INT,
ROLE_ID                    INT,
ICT                        INT,
MEMBER_TYPE            VARCHAR,
UUID                   VARCHAR,
CREATED_DATE     TIMESTAMP_NTZ,
UPDATED_DATE     TIMESTAMP_NTZ,
MERGE_ID               VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
