CREATE OR REPLACE TABLE MARKETING.PLAN
(
PLAN_KEY                         NUMBER,
DIVISION_KEY                     NUMBER,
PLAN_NBR                        VARCHAR,
PLAN_DESC                       VARCHAR,
PLAN_TYPE                       VARCHAR,
PRODUCT_CODE                    VARCHAR,
PRODUCT_DESC                    VARCHAR,
HEALTHY_U                       VARCHAR,
BUSINESS_INSURED_TYPE           VARCHAR,
LINE_OF_BUSINESS                VARCHAR,
LOAD_DATE                 TIMESTAMP_NTZ,
UPDATE_DATE               TIMESTAMP_NTZ
)
COMMENT='Created for MARKETING Migration'
;
