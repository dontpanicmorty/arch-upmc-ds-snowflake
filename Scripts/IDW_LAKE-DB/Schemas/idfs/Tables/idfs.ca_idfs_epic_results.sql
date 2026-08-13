CREATE OR REPLACE TABLE IDFS.CA_IDFS_EPIC_RESULTS
(
ORDER_PROC_ID             NUMBER(18),
EMPI                         VARCHAR,
PAT_ID                       VARCHAR,
PAT_ENC_CSN_ID            NUMBER(18),
ORDERING_DATE          TIMESTAMP_NTZ,
PROC_ID                   NUMBER(18),
DESCRIPTION                  VARCHAR,
COMPONENT_ID              NUMBER(18),
NAME                         VARCHAR,
SPECIMN_TAKEN_TIME     TIMESTAMP_NTZ,
RESULT_DATE            TIMESTAMP_NTZ,
RESULT_TIME            TIMESTAMP_NTZ,
FIXED_NUM_VALUE               NUMBER,
ORD_VALUE                    VARCHAR,
ORD_NUM_VALUE             FLOAT(126),
LAB_STATUS_C              NUMBER(38),
RESULT_STATUS_C           NUMBER(38),
REFERENCE_LOW                VARCHAR,
REFERENCE_HIGH               VARCHAR,
REFERENCE_UNIT               VARCHAR,
RESULT_IN_RANGE_YN           VARCHAR,
REF_NORMAL_VALS              VARCHAR,
CPT_CODE                     VARCHAR,
LOINC_CODE                   VARCHAR,
DEFAULT_LNC_ID            NUMBER(18),
HP_MMI                       VARCHAR
)
COMMENT='Created for IDFS Migration'
;
