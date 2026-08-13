CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREMANAGER
(
ID                                 INT,
USER_ID                            INT,
CREATED_DATE             TIMESTAMP_NTZ,
UPDATED_DATE             TIMESTAMP_NTZ,
SERVICE_LOCATION_ID                INT,
FIRST_NAME                     VARCHAR,
MIDDLE_NAME                    VARCHAR,
LAST_NAME                      VARCHAR,
PHONE                          VARCHAR,
MOBILE                         VARCHAR,
WORKPHONE                      VARCHAR,
COUNTRY_ID                         INT,
REGION_ID                          INT,
CITY_ID                            INT,
ORGANIZATION                   VARCHAR,
ORGANIZATION_ADDRESS           VARCHAR,
GENDER                         VARCHAR,
GRANTDIR                           INT,
POSTAL_CODE                    VARCHAR,
AVATAR                         VARCHAR,
COUNTY_ID                          INT,
SPECIALIZATION_ID                  INT,
DO_NOT_AUTO_ASSIGN                 INT,
PHONE_EXT                      VARCHAR,
UUID                           VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
