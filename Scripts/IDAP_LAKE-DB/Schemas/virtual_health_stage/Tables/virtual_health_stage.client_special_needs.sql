CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CLIENT_SPECIAL_NEEDS
(
ID                                  INT,
USER_ID                             INT,
SPECIAL_NEEDS_ID                    INT,
CREATED_DATE              TIMESTAMP_NTZ,
SYSRULES_DISABLE_FLAG               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
