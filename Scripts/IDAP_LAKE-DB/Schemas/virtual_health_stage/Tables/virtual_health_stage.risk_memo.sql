CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.RISK_MEMO
(
ID                               INT,
RISK_NAME                    VARCHAR,
CREATOR_ID                       INT,
CLIENT_ID                        INT,
MEMO                         VARCHAR,
CREATED_DATE           TIMESTAMP_NTZ,
RISK_UPDATED_DATE      TIMESTAMP_NTZ,
OLD_WEIGHT                       INT,
OLD_WEIGHT_DECIMAL      DECIMAL(6,3),
NEW_WEIGHT                       INT,
NEW_WEIGHT_DECIMAL      DECIMAL(6,3),
RISK_DETAILS                 VARCHAR,
OLD_RISK_DETAILS             VARCHAR,
OLD_LABEL                    VARCHAR,
NEW_LABEL                    VARCHAR,
MERGE_ID                     VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
