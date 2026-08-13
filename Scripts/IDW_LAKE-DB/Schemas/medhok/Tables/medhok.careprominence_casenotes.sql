CREATE OR REPLACE TABLE MEDHOK.CAREPROMINENCE_CASENOTES
(
MHK_CASE_NOTES_INT_ID                  VARCHAR,
NOTES_CREATED_AT                 TIMESTAMP_NTZ,
NOTES_CREATED_BY                       VARCHAR,
CTM_COMMENTS_SEND_TO_CMS               VARCHAR,
MHK_CTM_INT_ID                         VARCHAR,
MHK_GRIEVANCE_INT_ID                   VARCHAR,
MHK_APPEALS_INT_ID                     VARCHAR,
MHK_OTM_INT_ID                         VARCHAR,
MHK_EXRM_INT_ID                        VARCHAR,
MHK_COMPLIANCE_INT_ID                  VARCHAR,
MHK_RCA_INT_ID                         VARCHAR,
MHK_INTERDISCIPLINARY_INT_ID           VARCHAR,
IS_EXTERNAL_NOTE                       VARCHAR,
MHK_MTM_INT_ID                         VARCHAR,
MHK_PROV_DISPUTE_INT_ID                VARCHAR,
MHK_SUBTASK_INT_ID                     VARCHAR,
MHK_MMR_INT_ID                         VARCHAR,
CLIENT_ID                              VARCHAR,
TPA_ID                                 VARCHAR,
TPA_DIV                                VARCHAR,
FILE_NAME                              VARCHAR,
LOAD_DATE                        TIMESTAMP_NTZ,
CONSTRAINT CAREPROMINENCE_CASENOTES_PK PRIMARY KEY (MHK_CASE_NOTES_INT_ID)
)
COMMENT='Created for MEDHOK Migration'
;
