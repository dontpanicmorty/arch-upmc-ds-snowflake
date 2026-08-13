CREATE OR REPLACE TABLE HPANALYTICS.BOOK_RX_NEW
(
CORPORATION_ID                      VARCHAR,
GROUP_ID                            VARCHAR,
DIVISION_ID                         VARCHAR,
PLAN_NBR                            VARCHAR,
DRUG_NAME_BRAND                     VARCHAR,
THER_CLASS_CODE_AHFS_DESC           VARCHAR,
SPECIALTY_DRUG                      VARCHAR,
RX                                   NUMBER(33,5),
RX_PAID                              NUMBER(33,5),
SERVICE_DATE                  TIMESTAMP_NTZ,
PAYMENT_DATE                  TIMESTAMP_NTZ,
DAY_SUPPLY_CNT                       NUMBER(33,5),
MEMBER_CNT                           NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
