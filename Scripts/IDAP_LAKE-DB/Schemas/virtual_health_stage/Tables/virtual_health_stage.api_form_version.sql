CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.API_FORM_VERSION
(
ID                             INT,
TYPE                       VARCHAR,
FORM_ID                        INT,
MD5                        VARCHAR,
VERSION_CODE                   INT,
ENDPOINT_VERSION           VARCHAR,
TITLE                      VARCHAR,
CONFIG                     VARCHAR,
IS_ACTUAL                      INT,
CREATED_DATE         TIMESTAMP_NTZ,
UPDATED_DATE         TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
