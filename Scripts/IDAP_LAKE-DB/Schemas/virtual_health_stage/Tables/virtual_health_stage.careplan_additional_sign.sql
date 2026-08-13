CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_ADDITIONAL_SIGN
(
ID                                INT,
CAREPLAN_ID                       INT,
AUTHOR_ID                         INT,
CARETEAM_HISTORY_ID               INT,
NAME                          VARCHAR,
TYPE                          VARCHAR,
DESIGNATION                   VARCHAR,
SIGNATURE                     VARCHAR,
FINGERPRINT                   VARCHAR,
CREATED_DATE            TIMESTAMP_NTZ
)
COMMENT='Created for UPMCVH_PROD Migration'
;
