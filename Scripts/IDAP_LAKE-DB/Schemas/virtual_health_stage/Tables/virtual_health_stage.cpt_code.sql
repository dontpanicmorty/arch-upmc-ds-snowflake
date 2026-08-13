CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CPT_CODE
(
CPT_CODE                          VARCHAR,
CPT_DESCRIPTOR                    VARCHAR,
CLINICIAN_DESCRIPTOR_ID           VARCHAR,
CLINICIAN_DESCRIPTOR              VARCHAR,
ID                                    INT,
UPDATED_DATE                TIMESTAMP_NTZ,
START_DATE                  TIMESTAMP_NTZ,
END_DATE                    TIMESTAMP_NTZ,
SERVICE_GROUP                     VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
