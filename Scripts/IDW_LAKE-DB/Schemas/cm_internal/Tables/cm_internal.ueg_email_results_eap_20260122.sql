CREATE OR REPLACE TABLE CM_INTERNAL.UEG_EMAIL_RESULTS_EAP_20260122
(
MEMBER_NBR                                       VARCHAR,
MAIL_DATE                                  TIMESTAMP_NTZ,
WAVE                                             VARCHAR,
FLAG_SENT                                         NUMBER,
FLAG_OPEN                                         NUMBER,
FLAG_CLICK_THROUGH                                NUMBER,
FLAG_EAP_CASE_OPEN_WI_30DAYS                      NUMBER,
FIRST_EAP_CASE_OPEN_WI_30DAYS              TIMESTAMP_NTZ,
FLAG_EAP_ANY_ACTIVITY_WI_30DAYS                   NUMBER,
FIRST_EAP_ACTIVITY_WI_30DAYS               TIMESTAMP_NTZ,
FLAG_EAP_COUNSELING_SESSION_WI_30DAYS             NUMBER,
FIRST_EAP_COUNSELING_SESSION_WI_30DAYS     TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
