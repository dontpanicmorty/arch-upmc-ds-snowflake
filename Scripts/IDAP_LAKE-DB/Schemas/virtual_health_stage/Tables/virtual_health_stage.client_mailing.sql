CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_MAILING
(
ID                                  INT,
CLIENT_ID                           INT,
ADDRESS1                        VARCHAR,
ADDRESS2                        VARCHAR,
CITY_ID                             INT,
ZIP_CODE                        VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
REGION_ID                           INT,
SYSRULES_DISABLE_FLAG               INT,
LAST_UPDATED_BY                     INT,
COUNTRY_ID                          INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
