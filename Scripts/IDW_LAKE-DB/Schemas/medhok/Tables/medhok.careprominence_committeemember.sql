CREATE OR REPLACE TABLE MEDHOK.CAREPROMINENCE_COMMITTEEMEMBER
(
CM_COUNTER                          VARCHAR,
MEMBER_NAME                         VARCHAR,
MEMBER_TITLE                        VARCHAR,
MEMBER_DECISION                     VARCHAR,
MHK_DER_INTERNAL_ID                 VARCHAR,
MHK_APPEALS_INTERNAL_ID             VARCHAR,
MHK_GRIEVANCE_INTERNAL_ID           VARCHAR,
CREATED_AT                    TIMESTAMP_NTZ,
UPDATED_AT                    TIMESTAMP_NTZ,
CREATED_BY                          VARCHAR,
UPDATED_BY                          VARCHAR,
CLIENT_ID                           VARCHAR,
TPA_ID                              VARCHAR,
TPA_DIV                             VARCHAR,
FILE_NAME                           VARCHAR,
LOAD_DATE                     TIMESTAMP_NTZ
)
COMMENT='Created for MEDHOK Migration'
;
