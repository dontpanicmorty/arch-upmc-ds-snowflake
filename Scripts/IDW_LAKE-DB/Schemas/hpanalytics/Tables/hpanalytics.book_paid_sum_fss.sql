CREATE OR REPLACE TABLE HPANALYTICS.BOOK_PAID_SUM_FSS
(
CORPORATION_ID                VARCHAR,
GROUP_ID                      VARCHAR,
DIVISION_ID                   VARCHAR,
PLAN_NBR                      VARCHAR,
PAYMENT_DATE            TIMESTAMP_NTZ,
IP_CLAIM_NBR                  VARCHAR,
OP_CLAIM_NBR                  VARCHAR,
PROF_CLAIM_NBR                VARCHAR,
FSS                            NUMBER(33,5),
FS_DESC                       VARCHAR,
IP_PAID_GROSS_AMT              NUMBER(33,5),
OP_PAID_GROSS_AMT              NUMBER(33,5),
PROF_PAID_GROSS_AMT            NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
