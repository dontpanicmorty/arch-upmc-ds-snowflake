CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ADMINISTRATOR
(
ID                              INT,
USER_ID                         INT,
FIRST_NAME                  VARCHAR,
MIDDLE_NAME                 VARCHAR,
LAST_NAME                   VARCHAR,
PHONE                       VARCHAR,
COUNTRY_ID                      INT,
REGION_ID                       INT,
CITY_ID                         INT,
CREATED_DATE          TIMESTAMP_NTZ,
UPDATED_DATE          TIMESTAMP_NTZ,
AVATAR                      VARCHAR,
COUNTY_ID                       INT,
SPECIALIZATION_ID               INT,
PHONE_EXT                   VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
