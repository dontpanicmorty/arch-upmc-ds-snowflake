CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.CAREPLAN_PROBLEM_REFERENCE
(
ID                                    INT,
UUID                              VARCHAR,
TYPE                              VARCHAR,
VALUE                             VARCHAR,
VALUE_MD5                         VARCHAR,
LOCKED                                INT,
POSITION                              INT,
PRIORITY                              INT,
IN_FILTER                             INT,
MAP_TRACKING                          INT,
RANKING                               INT,
PROTECTED                             INT,
EPISODE_STATUS_TYPE               VARCHAR,
LAST_UPDATED_BY                       INT,
STATUS                                INT,
PROBLEM_STATUS_TYPE               VARCHAR,
CAN_BE_SET_BY_USER                    INT,
CAN_BE_SET_BY_USER_FOR_UPDATE         INT,
TAG_NAMES                         VARCHAR
)
COMMENT='Created for UPMCVH_PROD Migration'
;
