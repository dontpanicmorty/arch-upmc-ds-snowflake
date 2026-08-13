CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.PUBLICATION
(
ID                                INT,
OWNER                             INT,
USER_ID                           INT,
FILENAME                      VARCHAR,
CREATED_DATE            TIMESTAMP_NTZ,
UPDATED_DATE            TIMESTAMP_NTZ,
TITLE                         VARCHAR,
IS_DELETED                        INT,
CATEGORY                          INT,
TYPE                              INT,
SUB_TYPE                          INT,
NON_OWNER_CAN_SHARE               INT
)
COMMENT='CREATED FOR UPMCVH_PROD MIGRATION'
;
