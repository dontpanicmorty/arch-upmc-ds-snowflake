CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.RISK
(
ID                                  INT,
CLIENT_ID                           INT,
NAME                            VARCHAR,
WEIGHT                              INT,
WEIGHT_DECIMAL             DECIMAL(6,3),
DETAILS                         VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
IS_LOCKED                           INT,
WAS_SET_MANUALLY                    INT,
MAXWELL_IMPORT_FLAG                 INT,
SYSRULES_DISABLE_FLAG               INT,
EXTERNAL_ID                     VARCHAR,
ADDITIONAL_TYPE_ID                  INT,
MERGE_ID                        VARCHAR,
UUID                            VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
