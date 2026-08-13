CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ATTESTATION
(
ID                                    INT,
TEMPLATE_SNAPSHOT_ID                  INT,
CLIENT_INFO_SNAPSHOT_ID               INT,
USER_ID                               INT,
CLIENT_ID                             INT,
ANSWERS                           VARCHAR,
IS_DELETED                            INT,
CREATED_DATE                TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
