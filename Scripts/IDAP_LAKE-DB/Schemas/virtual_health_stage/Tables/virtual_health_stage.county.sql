CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.COUNTY
(
ID                                  INT,
COUNTRY_ID                          INT,
REGION_ID                           INT,
TITLE                           VARCHAR,
TX_COUNTY_CODE                  VARCHAR,
RESIDENCE_COUNTY_CODE           VARCHAR,
CREATED_AT                TIMESTAMP_NTZ,
UPDATED_AT                TIMESTAMP_NTZ,
TYPE                                INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
