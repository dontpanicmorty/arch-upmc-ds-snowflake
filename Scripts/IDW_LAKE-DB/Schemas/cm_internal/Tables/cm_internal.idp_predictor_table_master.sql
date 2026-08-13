CREATE OR REPLACE TABLE CM_INTERNAL.IDP_PREDICTOR_TABLE_MASTER
(
PREDICTOR_ID                           VARCHAR,
PREDICTOR_GROUP                        VARCHAR,
PREDICTOR_NAME                         VARCHAR,
PREDICTOR_DEFINITION                   VARCHAR,
PREDICTOR_NAME_ARCHIVE                 VARCHAR,
PREDICTOR_DEFINITION_ARCHIVE           VARCHAR,
MACHINE_LEARNING                    NUMBER(38),
SIMPLE_MODEL                        NUMBER(38),
RANK_ORDER                          NUMBER(38),
RUN_DTTM                         TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
