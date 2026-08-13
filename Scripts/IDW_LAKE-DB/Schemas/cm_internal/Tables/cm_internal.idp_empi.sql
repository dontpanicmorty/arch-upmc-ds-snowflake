CREATE OR REPLACE TABLE CM_INTERNAL.IDP_EMPI
(
EMPI_ID                    VARCHAR,
MEMBER_NBR                 VARCHAR,
EMPLOYEE_ID                VARCHAR,
ABSENTYS_ID                VARCHAR,
WC_ID                      VARCHAR,
STD_ID                     VARCHAR,
MASTER_MEMBER_ID           VARCHAR,
LAST_NAME                  VARCHAR,
FIRST_NAME                 VARCHAR,
DOB                        VARCHAR,
SSN                        VARCHAR,
DATE_UPDATED         TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
