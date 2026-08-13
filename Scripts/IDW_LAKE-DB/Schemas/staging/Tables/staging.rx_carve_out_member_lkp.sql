CREATE OR REPLACE TABLE STAGING.RX_CARVE_OUT_MEMBER_LKP
(
LOB                                 VARCHAR,
MEMBER_NBR                          VARCHAR,
MEMBER_SSN                          VARCHAR,
RECIPIENT_NBR                       VARCHAR,
NAME_FIRST                          VARCHAR,
NAME_LAST                           VARCHAR,
BIRTH_DATE                    TIMESTAMP_NTZ,
CONTRACT_NBR                        VARCHAR,
CONTRACT_RELATIONSHIP_NBR           VARCHAR,
SUBSCRIBER_SSN                      VARCHAR,
HIGHMARK_CODE                       VARCHAR
)
COMMENT='Created for STAGING Migration'
;
