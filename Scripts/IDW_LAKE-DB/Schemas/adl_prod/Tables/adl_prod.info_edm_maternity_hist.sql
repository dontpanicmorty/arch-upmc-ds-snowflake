CREATE OR REPLACE TABLE ADL_PROD.INFO_EDM_MATERNITY_HIST
(
EDM_SOURCE                          VARCHAR,
EDM_TYPE                            VARCHAR,
MMI                                 VARCHAR,
MEMBER_NBR                          VARCHAR,
EVENT_DATE                    TIMESTAMP_NTZ,
DUE_DATE                      TIMESTAMP_NTZ,
DUE_DATE_SOURCE                     VARCHAR,
GESTATIONAL_AGE               DOUBLE,
CURR_PREG                           VARCHAR,
CURR_PREG_LATEST_EVENT        DOUBLE,
PREG_END                      DOUBLE,
PREG_END_DATE                 TIMESTAMP_NTZ,
PREG_END_SOURCE                     VARCHAR,
CLAIM_NBR                           VARCHAR,
PRIMARY_ICD                         VARCHAR,
CASE_ID                             VARCHAR,
ONAF_TRIMESTER                      VARCHAR,
ONAF_DELIV_DATE               TIMESTAMP_NTZ,
ONAF_FIRST_PRENATAL_VISIT     TIMESTAMP_NTZ,
RECORD_ID                           VARCHAR,
LOAD_DATE                     TIMESTAMP_NTZ,
UPDATE_DATE                   TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
