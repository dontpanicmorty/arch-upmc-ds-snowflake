CREATE OR REPLACE TABLE HPANALYTICS.BOOK_TELEHEALTH
(
MEMBER_NBR                      VARCHAR,
CORPORATION_ID                  VARCHAR,
CORPORATION_NAME                VARCHAR,
GROUP_ID                        VARCHAR,
GROUP_DESC                      VARCHAR,
DIVISION_ID                     VARCHAR,
DIVISION_DESC                   VARCHAR,
PLAN_NBR                        VARCHAR,
CLAIM_NBR                       VARCHAR,
FS                               NUMBER(33,5),
FSS                              NUMBER(33,5),
FSS_DESC                        VARCHAR,
SVCDATE                   TIMESTAMP_NTZ,
SVCDATEYYYYMM                   VARCHAR,
PDDATE                    TIMESTAMP_NTZ,
CPT4_CODE                       VARCHAR,
CPT4_DESC                       VARCHAR,
MODIFIER_CODE                   VARCHAR,
ICD_DIAGNOSIS_ID                VARCHAR,
ICD_DIAGNOSIS_DESC              VARCHAR,
BENEFIT_CATEGORY_CODE           VARCHAR,
BENEFIT_CATEGORY_DESC           VARCHAR,
UPMC_OWNED                      VARCHAR,
PAID_GROSS                       NUMBER(33,5),
EST_PAID_GROSS                   NUMBER(33,5)
)
COMMENT='Created for HPANALYTICS Migration'
;
