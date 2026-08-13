CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.COUNTRY
(
ID                                 INT,
TITLE                          VARCHAR,
FIPS104                        VARCHAR,
ISO2                           VARCHAR,
ISO3                           VARCHAR,
ISON                           VARCHAR,
INTERNET                       VARCHAR,
CAPITAL                        VARCHAR,
MAP_REFERENCE                  VARCHAR,
NATIONALITY_SINGULAR           VARCHAR,
NATIONALITY_PLURAL             VARCHAR,
CURRENCY                       VARCHAR,
CURRENCY_CODE                  VARCHAR,
POPULATION                         INT,
OFFICIAL_TITLE                 VARCHAR,
COMMENT                        VARCHAR,
CREATED_AT               TIMESTAMP_NTZ,
UPDATED_AT               TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
