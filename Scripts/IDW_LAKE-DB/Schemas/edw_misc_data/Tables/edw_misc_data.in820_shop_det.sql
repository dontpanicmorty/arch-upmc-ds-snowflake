CREATE OR REPLACE TABLE EDW_MISC_DATA.IN820_SHOP_DET
(
RECORD_TYPE                     VARCHAR,
EXG_ASD_SUB_ID               NUMBER(30),
LAST_NAME                       VARCHAR,
FIRST_NAME                      VARCHAR,
MIDDLE_INI                      VARCHAR,
EXG_ASD_QUAL_HP_ID              VARCHAR,
EXG_ASD_POL_ID                  VARCHAR,
EXG_ASD_DEP_ID                  VARCHAR,
EMPLOYER_PREM               NUMBER(9,2),
EMPLOYER_PREM_PAY_ID            VARCHAR,
EMPLOYER_PAY_COV_DATE           VARCHAR,
EMPLOYEE_PREM               NUMBER(9,2),
EMPLOYEE_PREM_PAY_ID            VARCHAR,
EMPLOYEE_PAY_COV_DATE           VARCHAR,
DEPEN_PREM                  NUMBER(9,2),
DEPEN_PREM_PAY_ID               VARCHAR,
DEPEN_PREM_COV_DATE             VARCHAR,
ISS_ASD_EMP_GRP_ID              VARCHAR,
ISS_ASD_POL                     VARCHAR,
ISS_ASD_DEP_ID                  VARCHAR,
ISS_ASD_SUB_ID                  VARCHAR,
MBR_NM_SUFX                     VARCHAR,
FILE_NAME                       VARCHAR,
LOAD_DATE                 TIMESTAMP_NTZ
)
COMMENT='Created for EDW_MISC_DATA Migration'
;
