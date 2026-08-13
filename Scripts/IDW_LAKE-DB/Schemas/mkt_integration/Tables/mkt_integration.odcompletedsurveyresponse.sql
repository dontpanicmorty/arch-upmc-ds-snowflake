CREATE OR REPLACE TABLE  MKT_INTEGRATION.ODCOMPLETEDSURVEYRESPONSE
(
SURVEY_ID                         VARCHAR,
SURVEY_NAME                       VARCHAR,
RESPONSE_ID                       VARCHAR,
RESPONSE_SET                      VARCHAR,
IPADDRESS                         VARCHAR,
START_DATE                   TIMESTAMP(6),
END_DATE                     TIMESTAMP(6),
FINISHED                          VARCHAR,
STATUS                            VARCHAR,
VERSION                           VARCHAR,
CID                               VARCHAR,
LOAD_DT                      TIMESTAMP(6),
MEMBER_NBR                        VARCHAR,
AUDIENCE_SELECTION_DATE      TIMESTAMP(6),
CAMPAIGN_NAME                     VARCHAR,
CAMPAIGN_CODE                     VARCHAR,
CREATIVE_CONTENT_CODE             VARCHAR,
UPLOADED_DATE               TIMESTAMP_NTZ
)
COMMENT='Created for MKT_INTEGRATION Migration'
;
