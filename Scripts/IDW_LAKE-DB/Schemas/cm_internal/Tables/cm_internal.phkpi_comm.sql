CREATE OR REPLACE TABLE CM_INTERNAL.PHKPI_COMM
(
MASTER_MEMBER_ID             VARCHAR,
MEMBER_NBR                   VARCHAR,
MEMBERSHIP_DATE        TIMESTAMP_NTZ,
MEMBER_CNT                    NUMBER,
LOB                          VARCHAR,
MEMBER_STATE                 VARCHAR,
MEMBER_COUNTY                VARCHAR,
REGION                       VARCHAR,
SUBREGION                    VARCHAR,
EXPENSE_MED                   NUMBER,
EXPENSE_RX                    NUMBER,
EXPENSE_RX_REBATES            NUMBER,
EXPENSE_RX_NET                NUMBER,
EXPENSE_DENTAL                NUMBER,
EXPENSE_VISION                NUMBER,
EXPENSE_TOTAL                 NUMBER,
PREMIUM                       NUMBER
)
COMMENT='Created for CM_INTERNAL Migration'
;
