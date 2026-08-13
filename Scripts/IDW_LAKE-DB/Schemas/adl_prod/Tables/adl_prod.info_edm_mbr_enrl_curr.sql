CREATE OR REPLACE TABLE ADL_PROD.INFO_EDM_MBR_ENRL_CURR
(
EDM_SOURCE                VARCHAR,
EDM_TYPE                  VARCHAR,
MMI                       VARCHAR,
MEMBER_NBR                VARCHAR,
LOB                       VARCHAR,
LOB_DETAIL                VARCHAR,
CORP_ID                   VARCHAR,
CURR_MBR                   NUMBER,
DOB                 TIMESTAMP_NTZ,
GENDER                    VARCHAR,
LAST_NAME                 VARCHAR,
FIRST_NAME                VARCHAR,
MIDDLE_NAME               VARCHAR,
MEDICARE_ID               VARCHAR,
RECIPIENT_NBR             VARCHAR,
MEM_TYPE                  VARCHAR,
CURR_COUNTY               VARCHAR,
PLAN_START_DATE     TIMESTAMP_NTZ,
PLAN_END_DATE       TIMESTAMP_NTZ,
ENROLL_SEGMENT             NUMBER,
PRIMARY_INS                NUMBER,
CHC_SNP                    NUMBER,
CHC_OTHER                  NUMBER,
LOAD_DATE           TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;