CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.ASSIGNMENT_DISTANCE_MATRIX_CALL_LOG
(
ID                                  INT,
CLIENT_ID                           INT,
USER_ID                             INT,
ADDRESS                         VARCHAR,
DISTANCE                  DECIMAL(10,2),
CASELOAD                            INT,
ASSIGNMENT_PROFILE_ID               INT,
ASSIGNED                            INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
