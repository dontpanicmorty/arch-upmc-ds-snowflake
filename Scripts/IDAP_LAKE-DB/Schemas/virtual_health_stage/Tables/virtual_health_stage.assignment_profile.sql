CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ASSIGNMENT_PROFILE
(
ID                                  INT,
NAME                            VARCHAR,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
LAST_UPDATED_BY                     INT,
MAX_DISTANCE               DECIMAL(5,2),
SPECIALIZATION_ID                   INT,
ORGANIZATIONS                   VARCHAR,
ADDRESSES                       VARCHAR,
ZIP_CODES                       VARCHAR,
CITY_ID                             INT,
STATE_ID                            INT,
COUNTY_ID                           INT,
SUPERVISORS_STRING              VARCHAR,
DEPARTMENTS_STRING              VARCHAR,
MARKETS_STRING                  VARCHAR,
LOBS_STRING                     VARCHAR,
ACCESS_LEVELS_STRING            VARCHAR,
SPECIALIZATION_STRING           VARCHAR,
CITY_STRING                     VARCHAR,
STATE_STRING                    VARCHAR,
COUNTY_STRING                   VARCHAR
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
