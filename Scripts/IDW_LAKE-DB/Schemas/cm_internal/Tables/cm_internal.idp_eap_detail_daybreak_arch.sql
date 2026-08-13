CREATE OR REPLACE TABLE CM_INTERNAL.IDP_EAP_DETAIL_DAYBREAK_ARCH
(
EAP_ID                        NUMBER(33,5),
YYYYMM                        NUMBER(33,5),
SSN                          VARCHAR,
UNIQUE_ID                    VARCHAR,
NAME_FIRST                   VARCHAR,
NAME_MI                      VARCHAR,
NAME_LAST                    VARCHAR,
DATE_OF_BIRTH          TIMESTAMP_NTZ,
REFERRAL_FLAG                 NUMBER(33,5),
FMLA_PILOT                    NUMBER(33,5),
INITIAL_CONTACT               NUMBER(33,5),
WORKLIFE_CASE                 NUMBER(33,5),
INPERSON_CASE                 NUMBER(33,5),
TELEPHONIC_CASE               NUMBER(33,5),
BEATINGTHEBLUES               NUMBER(33,5),
EAP_CATEGORY                 VARCHAR,
OFFERED_HLTH_COACH           VARCHAR,
OFFERED_BTB                  VARCHAR
)
COMMENT='Created for CM_INTERNAL Migration'
;
