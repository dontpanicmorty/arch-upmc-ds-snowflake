CREATE OR REPLACE TABLE DA_POWERBI.FACT_WELLBEING_POPULATION
(
MEMBER_NBR                         VARCHAR,
CONTRACT_NBR                       VARCHAR,
MEMBER_TYPE_DESC                   VARCHAR,
NAME_FIRST                         VARCHAR,
NAME_LAST                          VARCHAR,
RELATIONSHIP_CODE                  VARCHAR,
RELATIONSHIP_DESC                  VARCHAR,
PHONE_NBR                          VARCHAR,
EMAIL_ADDRESS                      VARCHAR,
PREFERRED_CONTACT_METHOD           VARCHAR,
GENDER                             VARCHAR,
DATE_OF_BIRTH                TIMESTAMP_NTZ,
CLIENT_CODE                        VARCHAR,
CLIENT_NAME                        VARCHAR,
CORPORATION_ID                     VARCHAR,
GROUP_ID                           VARCHAR,
DIVISION_ID                        VARCHAR,
PLAN_NBR                           VARCHAR,
SPENDING_ACCOUNT                   VARCHAR,
MEMBERSHIP_DATE              TIMESTAMP_NTZ
)
COMMENT='Created for DA_POWERBI Migration'
;
