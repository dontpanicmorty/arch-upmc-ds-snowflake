CREATE OR REPLACE TABLE ADL_PROD.MOD_CALL_SUCCESS
(
MMI                      VARCHAR,
MEMBER_NBR               VARCHAR,
LOB                      VARCHAR,
CORPORATION_ID           VARCHAR,
OUT_OF_AREA              VARCHAR,
MINOR                    VARCHAR,
CALL_SCORE                NUMBER,
CALL_SCORE_INT            NUMBER,
RESPONDER                VARCHAR,
LOAD_DATE          TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
