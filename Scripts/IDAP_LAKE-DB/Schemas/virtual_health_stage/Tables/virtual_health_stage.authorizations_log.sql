CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.AUTHORIZATIONS_LOG
(
ID                                       INT,
TYPE                                 VARCHAR,
AUTHORIZATION_ID                         INT,
AUTHOR                               VARCHAR,
AUTHOR_ID                                INT,
SECTION                              VARCHAR,
FIELD_NAME                           VARCHAR,
OLD_VALUE                            VARCHAR,
NEW_VALUE                            VARCHAR,
CREATED_DATE                   TIMESTAMP_NTZ,
FINISHED                                 INT,
RELATED_ENTITY_NAME                  VARCHAR,
RELATED_ENTITY_ID                    VARCHAR,
RELATED_ENTITY_PRIMARY_KEY               INT,
GROUP_ID                             VARCHAR,
METADATA                             VARIANT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
