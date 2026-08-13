CREATE OR REPLACE TABLE CM_INTERNAL.IDP_HAND
(
HOS                              VARCHAR,
UNIT                             VARCHAR,
EVENT_DATE                 TIMESTAMP_NTZ,
MONITORS                          NUMBER(33,5),
HAND_HYGIENE_PREFORMED            NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
