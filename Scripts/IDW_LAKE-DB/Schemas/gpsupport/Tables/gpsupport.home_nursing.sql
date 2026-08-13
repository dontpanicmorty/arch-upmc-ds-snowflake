CREATE OR REPLACE TABLE GPSUPPORT.HOME_NURSING
(
CLAIM_NBR               VARCHAR,
RID                     VARCHAR,
REGION                  VARCHAR,
MCO                     VARCHAR,
DOB                      NUMBER,
CLAIM_RECEIVED_DATE      NUMBER,
CLM_LN                   NUMBER,
MAID                    VARCHAR,
POS                     VARCHAR,
ICN                     VARCHAR,
BEGIN_DOS                NUMBER,
END_DOS                  NUMBER,
PAY_DATE                 NUMBER,
AMT_PD                   NUMBER,
PROC_CODE               VARCHAR,
REV_CODE                VARCHAR,
PPEC                    VARCHAR,
ARR_YR                   NUMBER,
PROMISE_CLM             VARCHAR,
PROMISE_STATUS          VARCHAR,
MEMBER_NBR              VARCHAR,
VENDOR                  VARCHAR,
BILLED_AMT               NUMBER,
UNITS                    NUMBER
)
COMMENT='Created for GPSUPPORT Migration'
;
