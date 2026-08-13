CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_CHANGELOG
(
ID                          INT,
OWNER_ID                    INT,
CLIENT_ID                   INT,
CAREPLAN_TYPE           VARCHAR,
TYPE                    VARCHAR,
FIELDNAME               VARCHAR,
PREV                    VARCHAR,
CURRENT_RENAMED         VARCHAR,
CREATED_DATE      TIMESTAMP_NTZ,
UPDATED_DATE      TIMESTAMP_NTZ,
MERGE_ID                VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
