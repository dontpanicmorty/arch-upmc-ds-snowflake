CREATE OR REPLACE TABLE CM_INTERNAL.IDP_SAFETY_SCORES
(
BUSINESS_UNIT                                 VARCHAR,
MANAGEMENT_COMMITMENT_COMMUNICATION            NUMBER(33,5),
FIRST_SMART_GOAL                               NUMBER(33,5),
SECOND_SMART_GOAL                              NUMBER(33,5),
OVERALL_ACCOUNT_RATING                         NUMBER(33,5),
SCORE_MONTH                                   VARCHAR,
HRIS_BUSINESS_UNIT_ROLLUP                     VARCHAR,
DATE_LOADED                             TIMESTAMP_NTZ,
DATE_UPDATED                            TIMESTAMP_NTZ
)
COMMENT='Created for CM_INTERNAL Migration'
;
