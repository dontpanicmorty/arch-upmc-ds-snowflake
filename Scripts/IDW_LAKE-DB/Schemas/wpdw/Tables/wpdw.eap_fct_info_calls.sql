CREATE OR REPLACE TABLE WPDW.EAP_FCT_INFO_CALLS
(
CALL_NBR                                 NUMBER(33,5),
MEMBER_NBR                              VARCHAR,
EMPLOYEE_NBR                            VARCHAR,
INFO_CALL_DATE                    TIMESTAMP_NTZ,
EAP_INFORMATION_CALL_KEY                VARCHAR,
EAP_INFORMATION_CALL_TYPE_KEY           VARCHAR,
EMPLOYER_KEY                            VARCHAR,
EAP_CLIENT_KEY                          VARCHAR
)
COMMENT='Created for WPDW Migration'
;
