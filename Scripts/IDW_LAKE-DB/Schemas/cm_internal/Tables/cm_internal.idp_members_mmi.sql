CREATE OR REPLACE TABLE CM_INTERNAL.IDP_MEMBERS_MMI
(
SSN                            VARCHAR,
MEM_MONTH                      VARCHAR,
LAST_START               TIMESTAMP_NTZ,
BU_DESCRIPTION                 VARCHAR,
JOB_CODE                       VARCHAR,
JOB_CODE_DESCRIPTION           VARCHAR,
GL_PAY_TYPE_DESCR              VARCHAR,
AGE                             NUMBER(33,5),
GENDER                          NUMBER(33,5),
HOME_ZIP                       VARCHAR,
MARITAL_STATUS                 VARCHAR,
FULLPART                       VARCHAR,
HOURLY_RATE                     NUMBER(33,5),
PAY_CODE_APPLICABLE            VARCHAR,
MASTER_MEMBER_ID               VARCHAR,
EDW_APPLICABLE                 VARCHAR,
LOB                            VARCHAR
)
COMMENT='Created for CM_INTERNAL Migration'
;
