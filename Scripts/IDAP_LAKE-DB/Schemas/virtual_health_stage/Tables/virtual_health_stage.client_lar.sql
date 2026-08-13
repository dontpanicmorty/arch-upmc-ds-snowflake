CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_LAR
(
ID                                  INT,
CLIENT_ID                           INT,
FIRST_NAME                      VARCHAR,
LAST_NAME                       VARCHAR,
PRIMARY_PHONE                   VARCHAR,
ALTERNATE_PHONE                 VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
REQUESTED_BY                    VARCHAR,
FROM_DATE                 TIMESTAMP_NTZ,
THROUGH_DATE              TIMESTAMP_NTZ,
RELATIONSHIP                        INT,
EMAIL                           VARCHAR,
ADDRESS1                        VARCHAR,
ADDRESS2                        VARCHAR,
COUNTRY_ID                          INT,
REGION_ID                           INT,
CITY_ID                             INT,
POSTAL_CODE                     VARCHAR,
ICT                                 INT,
REMOVED_BY_ID                       INT,
REMOVED_BY_NAME                 VARCHAR,
MEMBER_REMOVED_DATE       TIMESTAMP_NTZ,
SYSRULES_DISABLE_FLAG               INT,
UUID                            VARCHAR,
MERGE_ID                        VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
