CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.EPISODE_CHANGELOG
(
ID                                    INT,
EPISODE_ID                            INT,
EPISODE_REFERRAL_ID                   INT,
USER_ID                               INT,
FIELD                             VARCHAR,
OLD_VALUE                         VARCHAR,
NEW_VALUE                         VARCHAR,
CREATED_DATE                TIMESTAMP_NTZ,
INTERACTION_UTR_RULE_ID               INT,
EPISODE_SYSTEM_RULE_ID                INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
