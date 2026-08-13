CREATE OR REPLACE TABLE EDW_MISC_DATA.ACES_DATA_REGISTRY_VBID
(
RESULT_DATE        TIMESTAMP_NTZ,
COMPLETED_DATE     TIMESTAMP_NTZ,
MEMBER_NBR               VARCHAR,
AGE                      VARCHAR,
GENDER                   VARCHAR,
ZIP_CODE              NUMBER(10),
I4                       VARCHAR,
C2                       VARCHAR,
N2                       VARCHAR,
C3                       VARCHAR,
N4                       VARCHAR,
I3                       VARCHAR,
C1                       VARCHAR,
I2                       VARCHAR,
N1                       VARCHAR,
I1                       VARCHAR,
N3                       VARCHAR,
C4                       VARCHAR,
CLIENT_ID                VARCHAR,
TPA_ID                   VARCHAR,
TPA_DIV                  VARCHAR,
LOAD_DATE          TIMESTAMP_NTZ,
FILE_NAME                VARCHAR
)
COMMENT='Created for EDW_MISC_DATA Migration'
;
