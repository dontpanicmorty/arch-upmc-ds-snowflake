CREATE OR REPLACE TABLE EDW_RPT.CHC_SERVICE_LOCATION
(
CHC_SERVICE_LOCATION_KEY            NUMBER,
LOAD_DATE                    TIMESTAMP_NTZ,
LOCATION_CODE                      VARCHAR,
HIAA_POS_CODE                      VARCHAR,
SERVICE_TYPE                       VARCHAR,
TREATMENT_TYPE_CM                  VARCHAR,
TREATMENT_TYPE_MA                  VARCHAR,
UPDATE_DATE                  TIMESTAMP_NTZ,
INNETWORK_IND                      VARCHAR,
HIAA_POS_DESC                      VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
