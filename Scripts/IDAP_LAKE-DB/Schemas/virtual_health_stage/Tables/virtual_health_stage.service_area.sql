CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SERVICE_AREA
(
ID                            INT,
NAME                      VARCHAR,
ADDRESS1                  VARCHAR,
ADDRESS2                  VARCHAR,
CITY_ID                       INT,
REGION_ID                     INT,
COUNTY_ID                     INT,
PHONE                     VARCHAR,
CREATED_DATE        TIMESTAMP_NTZ,
UPDATED_DATE        TIMESTAMP_NTZ,
LOCKED                        INT,
SYSTEM_ID                 VARCHAR,
IS_DELETED                    INT,
LAST_UPDATED_BY               INT,
POSITION                      INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
