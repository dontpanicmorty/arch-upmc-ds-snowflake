CREATE OR REPLACE TABLE HPANALYTICS.BOOK_THER
(
SERVICE_DATE                  TIMESTAMP_NTZ,
PAYMENT_DATE                  TIMESTAMP_NTZ,
CORPORATION_ID                      VARCHAR,
GROUP_ID                            VARCHAR,
DIVISION_ID                         VARCHAR,
PLAN_NBR                            VARCHAR,
THER_CLASS_CODE_AHFS_DESC           VARCHAR,
RX                                   NUMBER(33,5),
RX_PAID                              NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
