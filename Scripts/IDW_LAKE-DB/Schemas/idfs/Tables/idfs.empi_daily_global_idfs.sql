CREATE OR REPLACE TABLE IDFS.EMPI_DAILY_GLOBAL_IDFS
(
HEALTHPLAN_ID                 VARCHAR,
MASTERMEMBER                  VARCHAR,
LAST_NAME                     VARCHAR,
FIRST_NAME                    VARCHAR,
MIDDLE_NAME                   VARCHAR,
DOB                     TIMESTAMP_NTZ,
GENDER                        VARCHAR,
EMPI_ID                       VARCHAR,
EPIC_MRN                      VARCHAR,
MEDIPAC_MRN                   VARCHAR,
LOAD_DATE               TIMESTAMP_NTZ,
AMWELL_ID                     VARCHAR,
ELIGIBILITYENDDATE      TIMESTAMP_NTZ,
LOB                           VARCHAR,
CORPORATEID                   VARCHAR,
IDFS_LOAD_DATE          TIMESTAMP_NTZ,
HORIZON_HOMECARE_ID           VARCHAR,
EPIC_EAST_MRN                 VARCHAR,
SEXO                          VARCHAR,
BGENDER                       VARCHAR,
GENDER_ID                     VARCHAR,
EPIC_ENT_ID                   VARCHAR
)
COMMENT='Created for IDFS Migration'
;
