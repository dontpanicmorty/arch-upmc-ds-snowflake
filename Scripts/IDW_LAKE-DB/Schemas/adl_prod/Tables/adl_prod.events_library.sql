CREATE OR REPLACE TABLE ADL_PROD.EVENTS_LIBRARY
(
MMI                            VARCHAR,
EVENT_DATE               TIMESTAMP_NTZ,
EVENT_TYPE                     VARCHAR,
EVENT_SUBTYPE                  VARCHAR,
EVENT_SUBTYPE_DETAIL           VARCHAR,
EVENT_CODE                     VARCHAR,
EVENT_CODE_SOURCE              VARCHAR,
EVENT_SVC_PROV_ID              VARCHAR,
EVENT_SVC_PROV_UPMC             NUMBER,
EVENT_BAA                       NUMBER,
EVENT_PGA                       NUMBER,
EVENT_SOURCE                   VARCHAR,
LOAD_DATE                TIMESTAMP_NTZ
)
COMMENT='Created for ADL_PROD Migration'
;
