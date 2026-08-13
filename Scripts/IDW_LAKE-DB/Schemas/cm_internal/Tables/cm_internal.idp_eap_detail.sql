CREATE OR REPLACE TABLE CM_INTERNAL.IDP_EAP_DETAIL
(
EAPEXPERT_ID                  NUMBER(33,5),
DAYBREAK_ID                  VARCHAR,
YYYYMM                       VARCHAR,
CASE_OPEN_DATE         TIMESTAMP_NTZ,
NAME_FIRST                   VARCHAR,
NAME_MI                      VARCHAR,
NAME_LAST                    VARCHAR,
DATEOFBIRTH            TIMESTAMP_NTZ,
MEMBER_NBR                   VARCHAR,
EMPLOYEE_ID                  VARCHAR,
SELF_REFERRAL_FLAG            NUMBER(33,5),
FMLA_PILOT                    NUMBER(33,5),
INITIAL_CONTACT               NUMBER(33,5),
WORKLIFE_CASE                 NUMBER(33,5),
INPERSON_CASE                 NUMBER(33,5),
TELEPHONIC_CASE               NUMBER(33,5),
VIDEO_CASE                    NUMBER(33,5),
EAP_CATEGORY                 VARCHAR,
OFFERED_BTB                  VARCHAR,
OFFERED_HLTH_COACH           VARCHAR
)
COMMENT='Created for CM_INTERNAL Migration'
;
