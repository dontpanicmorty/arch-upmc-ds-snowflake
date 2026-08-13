CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.COMMON_LTSS_AUTHORIZATION_SERVICE_NOTE_HISTORY
(
ID                                     INT,
AUTHORIZATION_SERVICE_ID               INT,
REVIEW_STATUS                      VARCHAR,
REVIEW_STATUS_REASON               VARCHAR,
CREATED_DATE                 TIMESTAMP_NTZ,
REVIEW_NOTE                        VARCHAR,
USER_ID                                INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
