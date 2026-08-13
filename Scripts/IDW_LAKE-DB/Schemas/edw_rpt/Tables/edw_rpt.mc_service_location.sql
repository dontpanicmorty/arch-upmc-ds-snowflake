CREATE OR REPLACE TABLE EDW_RPT.MC_SERVICE_LOCATION
(
MC_SERVICE_LOCATION_KEY            NUMBER,
LOAD_DATE                   TIMESTAMP_NTZ,
LOCATION_CODE                     VARCHAR,
HIAA_POS_CODE                     VARCHAR,
SERVICE_TYPE                      VARCHAR,
TREATMENT_TYPE                    VARCHAR,
UPDATE_DATE                 TIMESTAMP_NTZ,
INNETWORK_IND                     VARCHAR,
HIAA_POS_DESC                     VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
