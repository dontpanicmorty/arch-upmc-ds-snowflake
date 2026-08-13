CREATE OR REPLACE TABLE MARKETING.ADDRESS
(
ADDRESS_KEY               NUMBER,
ADDRESS_TYPE             VARCHAR,
ADDRESS_LINE_1           VARCHAR,
ADDRESS_LINE_2           VARCHAR,
CITY                     VARCHAR,
STATE                    VARCHAR,
ZIP                      VARCHAR,
ZIP_EXT                  VARCHAR,
COUNTY                   VARCHAR,
COUNTRY                  VARCHAR,
PHONE                    VARCHAR,
FAX                      VARCHAR,
REGION_CODE              VARCHAR,
LATITUDE            NUMBER(19,9),
LONGITUDE           NUMBER(19,9),
LOAD_DATE          TIMESTAMP_NTZ,
UPDATE_DATE        TIMESTAMP_NTZ
)
COMMENT='Created for MARKETING Migration'
;
