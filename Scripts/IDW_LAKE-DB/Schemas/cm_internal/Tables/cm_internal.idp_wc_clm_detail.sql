CREATE OR REPLACE TABLE CM_INTERNAL.IDP_WC_CLM_DETAIL
(
YYYYMM                        NUMBER(33,5),
SSN                          VARCHAR,
CLAIM_ID                     VARCHAR,
CLAIM_NUMBER                 VARCHAR,
NEW_CLAIM                     NUMBER(33,5),
OPEN_CLAIM                    NUMBER(33,5),
TOTAL_PAID_AMT                NUMBER(33,5),
MEDICAL_PAID_AMT              NUMBER(33,5),
INDEMNITY_PAID_AMT            NUMBER(33,5),
EXPENSE_PAID_AMT              NUMBER(33,5),
OTHER_PAID_AMT                NUMBER(33,5),
WORK_LOSS_DAYS                NUMBER(33,5),
RESTRICTED_DAYS               NUMBER(33,5),
LITIGATION_FLAG               NUMBER(33,5),
CLAIM_TYPE                   VARCHAR,
DX_CODE                      VARCHAR,
DX_CODE_DESC                 VARCHAR,
CAUSE_CODE                   VARCHAR,
CAUSE_DESC                   VARCHAR,
INJURY_CODE                  VARCHAR,
INJURY_DESC                  VARCHAR,
CLAIM_START_DATE             VARCHAR,
FIRST_LWD              TIMESTAMP_NTZ,
LAST_LWD               TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
