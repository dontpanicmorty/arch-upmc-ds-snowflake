CREATE OR REPLACE TABLE GPSUPPORT.MA_837_FILTER_REJECTS
(
PLAN_TYPE              VARCHAR,
CLAIM_NBR              VARCHAR,
MEMBER                 VARCHAR,
BILLED                  NUMBER,
REJECT                  NUMBER,
REASON                 VARCHAR,
RECIPID                VARCHAR,
MA_CASE_NBR            VARCHAR,
PAID_AMT                NUMBER,
PROV_NAME              VARCHAR,
NPI                    VARCHAR,
MPI                    VARCHAR,
LOAD_DATE              VARCHAR,
DETAIL_DESCRIPTION     VARCHAR
)
COMMENT='Created for GPSUPPORT Migration'
;
