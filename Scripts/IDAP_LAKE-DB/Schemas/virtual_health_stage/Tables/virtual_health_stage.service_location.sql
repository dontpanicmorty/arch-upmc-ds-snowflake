CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SERVICE_LOCATION
(
ID                                  INT,
TYPE                            VARCHAR,
ADDRESS                         VARCHAR,
COUNTRY_ID                          INT,
REGION_ID                           INT,
CITY_ID                             INT,
POSTAL_CODE                     VARCHAR,
NAME                            VARCHAR,
PHONE                           VARCHAR,
FAX                             VARCHAR,
EMAIL                           VARCHAR,
WEBSITE                         VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
OWNER_ID                            INT,
COMMON                              INT,
DELETED                             INT,
PARENT_ID                           INT,
ADDRESS2                        VARCHAR,
UUID                            VARCHAR,
NETWORK_GROUP                       INT,
COUNTY_ID                           INT,
EXTERNAL_ID                     VARCHAR,
SOURCE                          VARCHAR,
MANUALLY_UPDATED_DATE     TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
