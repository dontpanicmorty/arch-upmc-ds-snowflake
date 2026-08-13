CREATE OR REPLACE TABLE EDW_MISC_DATA.IN820_SHOP_HDR
(
RECORD_TYPE                    VARCHAR,
TOT_PAYMENT_AMT           NUMBER(12,2),
CREDIT_DEBIT_FLAG_CD           VARCHAR,
PAY_METHOD_CD                  VARCHAR,
PAY_FORMAT                     VARCHAR,
DFI_ID_NBR_QUAL                VARCHAR,
DFI_ID_NBR                     VARCHAR,
ACCNT_NBR_QUAL                 VARCHAR,
ACCNT_NBR                      VARCHAR,
EFT_EFFECTIVE_DT         TIMESTAMP_NTZ,
CHK_EFT_TRC_NBR                VARCHAR,
PAYEE_NAME                     VARCHAR,
TAX_ID_NBR                     VARCHAR,
PAYER_NAME                     VARCHAR,
PAYER_ID                       VARCHAR,
PREM_PAY_CONT_NAME             VARCHAR,
PAYER_EMAIL                    VARCHAR,
PAYER_PHONE_NBR                VARCHAR,
FILE_NAME                      VARCHAR,
LOAD_DATE                TIMESTAMP_NTZ
)
COMMENT='Created for EDW_MISC_DATA Migration'
;
