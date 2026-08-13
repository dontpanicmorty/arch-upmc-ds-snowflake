CREATE OR REPLACE TABLE WPDW.EAP_DIM_CLIENT
(
EAP_CLIENT_KEY                         VARCHAR,
CLIENT_NBR                              NUMBER(33,5),
LAST_NAME                              VARCHAR,
MIDDLE_INITIAL                         VARCHAR,
FIRST_NAME                             VARCHAR,
MEMBER_NBR                             VARCHAR,
EMPLOYEE_NBR                           VARCHAR,
PRIMARY_PHONE_NBR                      VARCHAR,
PRIMARY_PHONE_NBR_RESTRICT             VARCHAR,
SECONDARY_PHONE_NBR                    VARCHAR,
SECONDARY_PHONE_NBR_RESTRICT           VARCHAR,
EMAIL_ADDRESS                          VARCHAR,
CURRENT_AGE                             NUMBER(33,5),
DATE_OF_BIRTH                    TIMESTAMP_NTZ,
GENDER                                 VARCHAR,
ETHNICITY                              VARCHAR,
HEALTH_PLAN                            VARCHAR,
MARITAL_STATUS                         VARCHAR,
FULL_ADDRESS                           VARCHAR,
ADDRESS_STREET                         VARCHAR,
ADDRESS_SUITE                          VARCHAR,
ADDRESS_CITY                           VARCHAR,
ADDRESS_STATE                          VARCHAR,
ADDRESS_ZIP_CODE                       VARCHAR,
COUNTY                                 VARCHAR,
LONGITUDE                               NUMBER(33,5),
LATITUDE                                NUMBER(33,5),
DELETED_STATUS                         VARCHAR
)
COMMENT='Created for WPDW Migration'
;
