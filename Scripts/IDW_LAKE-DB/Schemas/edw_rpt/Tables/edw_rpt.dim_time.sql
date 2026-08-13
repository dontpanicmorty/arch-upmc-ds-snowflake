CREATE OR REPLACE TABLE EDW_RPT.DIM_TIME
(
TIMESK              NUMBER(10),
TIME                   VARCHAR,
HR                     VARCHAR,
MILITARYHOUR           VARCHAR,
MIN                    VARCHAR,
SEC                    VARCHAR,
AMPM                   VARCHAR,
STANDARDTIME           VARCHAR,
LOAD_DATE        TIMESTAMP_NTZ
)
COMMENT='Created for EDWRPT Migration'
;
