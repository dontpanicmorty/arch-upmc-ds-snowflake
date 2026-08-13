CREATE OR REPLACE TABLE CM_INTERNAL.IDP_LEAVE_RETIRED_20180412
(
EMPLOYEEID                       VARCHAR,
SOCIAL_SECURITY_NUMBER           VARCHAR,
SVC_DATE                         VARCHAR,
APPROVEDDATE               TIMESTAMP_NTZ,
ABSENCETYPE                      VARCHAR,
LOSTDAYS                          NUMBER(33,5),
FMLA                              NUMBER(33,5),
PLOA                              NUMBER(33,5),
MIL                               NUMBER(33,5),
ATW                               NUMBER(33,5),
STD                               NUMBER(33,5),
WC                                NUMBER(33,5),
OWN                               NUMBER(33,5),
PREGNANCY                         NUMBER(33,5),
CHILD                             NUMBER(33,5),
SPOUSE                            NUMBER(33,5),
PARENT                            NUMBER(33,5),
MILITARY                          NUMBER(33,5),
ACCOMMODATION                     NUMBER(33,5)
)
COMMENT='Created for CM_INTERNAL Migration'
;
