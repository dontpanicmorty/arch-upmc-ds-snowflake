CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_INSURANCE_PLAN
(
ID                                    INT,
CLIENT_ID                             INT,
CLIENT_INSURANCE_ID                   INT,
CLIENT_INSURANCE_TYPE             VARCHAR,
CLIENT_INSURANCE_NUMBER           VARCHAR,
PLAN_ID                           VARCHAR,
PLAN_NAME                         VARCHAR,
GROUP_ID                          VARCHAR,
GROUP_NAME                        VARCHAR,
SERVICE_AREA_ID                       INT,
LOB_ID                                INT,
MARKET_ID                             INT,
PRODUCT_TYPE_ID                       INT,
ENROLLMENT_DATE             TIMESTAMP_NTZ,
TERMINATION_DATE            TIMESTAMP_NTZ,
SPAN_ID                           VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
