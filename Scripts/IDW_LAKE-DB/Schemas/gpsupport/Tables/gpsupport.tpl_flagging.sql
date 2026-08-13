CREATE OR REPLACE TABLE GPSUPPORT.TPL_FLAGGING
(
ICN                      VARCHAR,
DETAIL                   VARCHAR,
CODE_INDICATOR           VARCHAR,
DATE_SUBMIT              VARCHAR,
PLAN                     VARCHAR,
FILE_NAME                VARCHAR,
LOAD_DATE          TIMESTAMP_NTZ,
CLAIM_NBR                VARCHAR,
PROMISE_CLAIM            VARCHAR,
DESCRIPTION              VARCHAR
)
COMMENT='Created for GPSUPPORT Migration'
;
