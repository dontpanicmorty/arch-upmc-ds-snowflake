CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.USER
(
ID                                  INT,
USERNAME                        VARCHAR,
PASSWORD                       VARCHAR,
EMAIL                           VARCHAR,
ACTIVKEY                        VARCHAR,
TYPE                            VARCHAR,
EXTERNAL_ID                     VARCHAR,
CREATETIME                          INT,
STATUS                              INT,
ACTIVKEY_EXPIRATION       TIMESTAMP_NTZ,
DELETED_USER                        INT,
IS_TEST                             INT,
DELETED_DATE              TIMESTAMP_NTZ,
KILLER_ID                           INT,
IMPORT_STATUS                   VARCHAR,
UUID                            VARCHAR,
NETWORK_GROUP                       INT,
FIRST_NAME                      VARCHAR,
MIDDLE_NAME                     VARCHAR,
LAST_NAME                       VARCHAR,
SYSRULES_DISABLE_FLAG               INT,
CAN_DIRECT_LOGIN                    INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
