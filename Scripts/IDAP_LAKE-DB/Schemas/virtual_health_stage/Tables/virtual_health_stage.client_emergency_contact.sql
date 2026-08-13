CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_EMERGENCY_CONTACT
(
ID                                  INT,
CLIENT_ID                           INT,
FIRST_NAME                      VARCHAR,
LAST_NAME                       VARCHAR,
MIDDLE_NAME                     VARCHAR,
PRIMARY_PHONE                   VARCHAR,
ADDRESS1                        VARCHAR,
ADDRESS2                        VARCHAR,
COUNTRY_ID                          INT,
STATE_ID                            INT,
CITY_ID                             INT,
POSTAL_CODE                     VARCHAR,
MOBILE_PHONE                    VARCHAR,
WORK_PHONE                      VARCHAR,
EMAIL                           VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
ALTERNATE_PHONE                 VARCHAR,
RELATIONSHIP                        INT,
ICT                                 INT,
REMOVED_BY_ID                       INT,
REMOVED_BY_NAME                 VARCHAR,
MEMBER_REMOVED_DATE       TIMESTAMP_NTZ,
SYSRULES_DISABLE_FLAG               INT,
UUID                            VARCHAR,
MERGE_ID                        VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
