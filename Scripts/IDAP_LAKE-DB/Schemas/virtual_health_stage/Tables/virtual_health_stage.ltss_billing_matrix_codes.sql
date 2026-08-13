CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.LTSS_BILLING_MATRIX_CODES
(
ID                                  INT,
HCPCS_CODE                      VARCHAR,
MOD_1                           VARCHAR,
MOD_2                           VARCHAR,
MOD_3                           VARCHAR,
MOD_4                           VARCHAR,
SERVICE_CATEGORY_ID                 INT,
SERVICE_DESCRIPTION_ID              INT,
HCPCS_DESCRIPTOR                VARCHAR,
PER_UNIT                            INT,
UNIT_TYPE                       VARCHAR,
MAX_UNITS                           INT,
UNIT_COST                  DECIMAL(7,2)
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
