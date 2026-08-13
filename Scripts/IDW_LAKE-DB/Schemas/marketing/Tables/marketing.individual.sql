CREATE OR REPLACE TABLE MARKETING.INDIVIDUAL
(
INDIVIDUAL_KEY                           NUMBER,
INDIVIDUAL_ID                           VARCHAR,
HOUSEHOLD_KEY                            NUMBER,
ADDRESS_KEY                              NUMBER,
MEMBERSHIP_STATUS                       VARCHAR,
MASTER_MEMBER_ID                        VARCHAR,
TITLE                                   VARCHAR,
FIRST_NAME                              VARCHAR,
MIDDLE_INITIAL                          VARCHAR,
LAST_NAME                               VARCHAR,
SUFFIX                                  VARCHAR,
GENDER                                  VARCHAR,
BIRTH_DATE                        TIMESTAMP_NTZ,
AGE                                 NUMBER(5,2),
DECEASED_DATE                     TIMESTAMP_NTZ,
PREFERRED_CONTACT_METHOD_CODE           VARCHAR,
PREFERRED_CONTACT_METHOD_DESC           VARCHAR,
EMAIL_ADDRESS                           VARCHAR,
ALTERNATE_PHONE                         VARCHAR,
FIRST_MEMBERSHIP_DATE             TIMESTAMP_NTZ,
DO_NOT_CONTACT_IND                      VARCHAR,
LOAD_DATE                         TIMESTAMP_NTZ,
UPDATE_DATE                       TIMESTAMP_NTZ,
UCG_FLAG                              NUMBER(1)
)
COMMENT='Created for MARKETING Migration'
;
