CREATE OR REPLACE TABLE HCC_USER.HEALTHPLANET_OPEN_HCC
(
LOAD_DATE                  TIMESTAMP_NTZ,
MEMBER_NBR                       VARCHAR,
COUNT_HCC                         NUMBER,
HCC_MODEL                        VARCHAR,
HCC_CONDITION                     NUMBER,
HCC_DESCRIPTION                  VARCHAR,
ICD10_CM                         VARCHAR,
DIAGNOSIS_DESCRIPTION            VARCHAR,
DIAGNOSIS_DISPLAY_RANK            NUMBER
)
COMMENT='Created for HCC_USER Migration'
;