CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CITY
(
ID                                  INT,
COUNTRY_ID                          INT,
REGION_ID                           INT,
TITLE                           VARCHAR,
LATITUDE                          FLOAT,
LONGITUDE                         FLOAT,
TIME_ZONE                       VARCHAR,
DMA_ID                              INT,
COUNTY                          VARCHAR,
CODE                            VARCHAR,
WEATHER_LOCATION_CODE           VARCHAR,
WEOID                               INT,
CREATED_AT                TIMESTAMP_NTZ,
UPDATED_AT                TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
