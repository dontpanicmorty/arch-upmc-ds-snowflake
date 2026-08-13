CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SERVICE_DESCRIPTION_SERVICE_UNIT
(
ID                                    INT,
COHORT_ID                             INT,
SERVICE_DESCRIPTION_ID                INT,
UNIT_COST                           FLOAT,
CREATED_DATE                TIMESTAMP_NTZ,
UPDATED_DATE                TIMESTAMP_NTZ,
IS_DELETED                            INT,
LAST_UPDATED_BY                       INT,
IS_EXCLUDED_FROM_BUDGET               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
