CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.PLAN
(
ID                                          INT,
NAME                                    VARCHAR,
PLAN_ID                                 VARCHAR,
CREATED_DATE                      TIMESTAMP_NTZ,
UPDATED_DATE                      TIMESTAMP_NTZ,
TYPE                                        INT,
PRODUCT_TYPE_ID                             INT,
LOB_ID                                      INT,
DISENROLLMENT_PROCESSING_DAYS               INT,
REGION_ID                                   INT,
IS_DELETED                                  INT,
LAST_UPDATED_BY                             INT,
COHORT_ID                                   INT,
DECEASED_PROCESSING_DAYS                    INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
