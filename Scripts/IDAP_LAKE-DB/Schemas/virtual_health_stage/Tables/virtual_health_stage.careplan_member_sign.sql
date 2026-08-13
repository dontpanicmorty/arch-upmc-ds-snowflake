CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_MEMBER_SIGN
(
ID                                  INT,
CAREPLAN_ID                         INT,
SIGNATURE                       VARCHAR,
OPTION_RENAMED                      INT,
CREATED_DATE              TIMESTAMP_NTZ,
UPDATED_DATE              TIMESTAMP_NTZ,
FINGERPRINT                     VARCHAR,
COMMENTS                        VARCHAR,
SYSRULES_DISABLE_FLAG               INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
