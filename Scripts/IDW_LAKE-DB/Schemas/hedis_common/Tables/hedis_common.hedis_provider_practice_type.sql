CREATE OR REPLACE TABLE HEDIS_COMMON.HEDIS_PROVIDER_PRACTICE_TYPE
(
PROVIDER_ID                              VARCHAR,
PROVIDER_NPI                             VARCHAR,
PROVIDER_SPECIALTY                       VARCHAR,
TAXONOMY_CODE                            VARCHAR,
PROVIDER_SPECIALTY_DESCRIPTION           VARCHAR,
DENTIST                                  VARCHAR,
MENTAL_HEALTH                            VARCHAR,
OB_GYN_PRENATAL                          VARCHAR,
PRESCRIBING                              VARCHAR,
PCP                                      VARCHAR,
PRIMARY_CARE_PHYS                        VARCHAR,
EYE_CARE                                 VARCHAR,
NEPHROLOGIST                             VARCHAR,
LOAD_DATE                          TIMESTAMP_NTZ
)
COMMENT='Created for HEDIS_COMMON Migration'
;
