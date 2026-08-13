CREATE OR REPLACE TABLE HEDIS_COMMON.REL_MEMBER
(
MASTER_MEMBER_ID                         VARCHAR,
MEMBER_NBR                               VARCHAR,
RECIPIENT_NBR                            VARCHAR,
RACE_1_REL_DATA_SOURCE_ID                VARCHAR,
RACE_1_VALUE_SET_CODE                    VARCHAR,
RACE_1_DI                                VARCHAR,
RACE_1_DI_DETAIL                         VARCHAR,
RACE_2_REL_DATA_SOURCE_ID                VARCHAR,
RACE_2_VALUE_SET_CODE                    VARCHAR,
RACE_2_DI                                VARCHAR,
RACE_2_DI_DETAIL                         VARCHAR,
RACE_3_REL_DATA_SOURCE_ID                VARCHAR,
RACE_3_VALUE_SET_CODE                    VARCHAR,
RACE_3_DI                                VARCHAR,
RACE_3_DI_DETAIL                         VARCHAR,
ETHNICITY_1_REL_DATA_SOURCE_ID           VARCHAR,
ETHNICITY_1_VALUE_SET_CODE               VARCHAR,
ETHNICITY_1_DI                           VARCHAR,
ETHNICITY_1_DI_DETAIL                    VARCHAR,
LANGUAGE_1_REL_DATA_SOURCE_ID            VARCHAR,
LANGUAGE_1_VALUE_SET_CODE                VARCHAR,
LANGUAGE_1_DI                            VARCHAR,
LANGUAGE_1_DI_DETAIL                     VARCHAR,
LOAD_DATE                          TIMESTAMP_NTZ
)
COMMENT='Created for HEDIS_COMMON Migration'
;
