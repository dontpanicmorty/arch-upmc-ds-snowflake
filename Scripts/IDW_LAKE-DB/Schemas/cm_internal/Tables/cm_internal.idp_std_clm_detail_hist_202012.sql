CREATE OR REPLACE TABLE CM_INTERNAL.IDP_STD_CLM_DETAIL_HIST_202012
(
YYYYMM                      NUMBER(33,5),
SSN                        VARCHAR,
CLAIM_ID                   VARCHAR,
CLAIM_NUMBER               VARCHAR,
NEW_CLAIM                   NUMBER(33,5),
OPEN_CLAIM                  NUMBER(33,5),
PAID_AMOUNT                 NUMBER(33,5),
WORK_LOSS_DAYS              NUMBER(33,5),
RESTRICTED_DAYS             NUMBER(33,5),
CLAIM_TYPE                 VARCHAR,
DX_CODE                    VARCHAR,
DX_CODE_DESC               VARCHAR,
MDC                        VARCHAR,
STD_ELIG_LVL               VARCHAR,
CLAIM_START_DATE           VARCHAR,
FIRST_LWD            TIMESTAMP_NTZ,
LAST_LWD             TIMESTAMP_NTZ,
ODG_MIN                     NUMBER(33,5),
ODG_OPT                     NUMBER(33,5),
ODG_MAX                     NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
