CREATE OR REPLACE TABLE WPDW.RX_FOR_WELLNESS_PORTAL
(
RX4W_ID                            NUMBER(33,5),
CREATED_DATE                TIMESTAMP_NTZ,
MEMBER_ID                         VARCHAR,
PROVIDER_NAME                     VARCHAR,
REFERRING_PROVIDER_NAME           VARCHAR,
REFERRING_PROVIDER_ID             VARCHAR,
SITE_ID                           VARCHAR,
SPECIALTY_ID                      VARCHAR,
NPI                               VARCHAR,
CAN_ID                            VARCHAR,
CAN_NOTE                          VARCHAR,
DATE_UPDATED                TIMESTAMP_NTZ,
ENC_TYPE                          VARCHAR,
AUTH_PROV_NAME                    VARCHAR,
AUTH_PROV_SPECIALTY               VARCHAR,
AUTH_PROV_ID                      VARCHAR,
SHARED_SAVINGS_GROUP              VARCHAR,
GS_ZONE                           VARCHAR
)
COMMENT='Created for WPDW Migration'
;
