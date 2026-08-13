CREATE OR REPLACE TABLE HPANALYTICS.BOOK_MEDICAL
(
MEMBER_NBR           VARCHAR,
CLAIM_NBR            VARCHAR,
FS                    NUMBER(33,5),
FS_DESC              VARCHAR,
FSS                   NUMBER(33,5),
SVCDATE        TIMESTAMP_NTZ,
PDDATE         TIMESTAMP_NTZ,
SHOCK_CLM            VARCHAR,
ADMITS                NUMBER(33,5),
DAYS                  NUMBER(33,5),
PAID_GROSS            NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
