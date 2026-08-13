CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_PARTNER_CONTACT
(
ID                                  INT,
CLIENT_ID                           INT,
FIRST_NAME                      VARCHAR,
LAST_NAME                       VARCHAR,
MIDDLE_NAME                     VARCHAR,
ADDRESS1                        VARCHAR,
ADDRESS2                        VARCHAR,
COUNTRY_ID                          INT,
STATE_ID                            INT,
CITY_ID                             INT,
POSTAL_CODE                     VARCHAR,
PRIMARY_PHONE                   VARCHAR,
MOBILE_PHONE                    VARCHAR,
WORK_PHONE                      VARCHAR,
ALTERNATE_PHONE                 VARCHAR,
EMAIL                           VARCHAR,
ICT                                 INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
REMOVED_BY_ID                       INT,
REMOVED_BY_NAME                 VARCHAR,
MEMBER_REMOVED_DATE       TIMESTAMP_NTZ,
SYSRULES_DISABLE_FLAG               INT,
UUID                            VARCHAR,
MERGE_ID                        VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
