CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_ISP_STCW_CATEGORY_DESCRIPTION
(
ID                               INT,
SERVICE_CATEGORY_ID              INT,
TITLE                        VARCHAR,
ORDERLINESS                      INT,
UNIT_COST               DECIMAL(7,2),
HCPCS_CODE                   VARCHAR,
MOD1                         VARCHAR,
MOD2                         VARCHAR,
MOD3                         VARCHAR,
MOD4                         VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
