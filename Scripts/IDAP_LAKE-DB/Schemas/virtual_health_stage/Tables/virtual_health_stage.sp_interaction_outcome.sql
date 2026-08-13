CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SP_INTERACTION_OUTCOME
(
ID                                                 INT,
NAME                                           VARCHAR,
IS_DIRECTION_INCOMING                              INT,
IS_DIRECTION_OUTGOING                              INT,
DISPLAY_OUTGOING_CONTACT_RESULT_SUCCESSFUL         INT,
DISPLAY_OUTGOING_CONTACT_RESULT_UTR                INT,
IS_DELETABLE                                       INT,
IS_DELETED                                         INT,
LAST_UPDATED_BY                                    INT,
VALUE                                              INT,
IS_LOCKED                                          INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
