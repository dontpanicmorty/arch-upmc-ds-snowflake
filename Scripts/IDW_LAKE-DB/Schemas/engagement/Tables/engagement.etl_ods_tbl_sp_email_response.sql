CREATE OR REPLACE TABLE ENGAGEMENT.ETL_ODS_TBL_SP_EMAIL_RESPONSE
(
HASH_COMM_ID                    VARCHAR,
INDIVIDUAL_ID                   VARCHAR,
MEMBER_NBR                      VARCHAR,
MASTER_MEMBER_ID                VARCHAR,
MAIL_DATE                 TIMESTAMP_NTZ,
EMAIL                           VARCHAR,
CAMPAIGN_CODE                   VARCHAR,
CREATIVE_CONTENT_CODE           VARCHAR,
CLICK_LINK_NAME                 VARCHAR,
EVENT_TIMESTAMP           TIMESTAMP_NTZ,
EVENT_TYPE                      VARCHAR,
BUSINESS_KEY                 NUMBER(38),
CONTACT_KEY                     VARCHAR,
DUNS_NUMBER                     VARCHAR,
CAVULUS_LEAD_ID                 VARCHAR
)
COMMENT='Created for ENGAGEMENT Migration'
;
