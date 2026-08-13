CREATE OR REPLACE TABLE EDW_RPT.RIDER
(
RIDER_KEY                       NUMBER,
DIVISION_ID                    VARCHAR,
RIDER_CODE                     VARCHAR,
RIDER_DESC                     VARCHAR,
TIERING_METHOD                 VARCHAR,
RIDER_AMT1                NUMBER(11,2),
RIDER_AMT2                NUMBER(11,2),
RIDER_AMT3                NUMBER(11,2),
RIDER_AMT4                NUMBER(11,2),
RIDER_AMT5                NUMBER(11,2),
RIDER_EFFECTIVE_DATE     TIMESTAMP_NTZ,
RIDER_TERM_DATE          TIMESTAMP_NTZ,
LOAD_DATE                TIMESTAMP_NTZ,
UPDATE_DATE              TIMESTAMP_NTZ,
RIDER_TYPE                     VARCHAR,
RIDER_TYPE_DESC                VARCHAR,
FORMULARY_CODE                 VARCHAR,
FORMULARY_CODE_DESC            VARCHAR
)
COMMENT='Created for EDWRPT Migration'
;
