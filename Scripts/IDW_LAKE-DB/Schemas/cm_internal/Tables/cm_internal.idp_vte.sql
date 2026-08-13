CREATE OR REPLACE TABLE CM_INTERNAL.IDP_VTE
(
HOSPITAL                 VARCHAR,
UNIT                     VARCHAR,
EVENT_DATE         TIMESTAMP_NTZ,
MONTHLY_CENSUS            NUMBER(33,5),
VTE                       NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
