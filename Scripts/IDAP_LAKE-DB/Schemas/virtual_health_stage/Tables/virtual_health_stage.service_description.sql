CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.SERVICE_DESCRIPTION
(
ID                               INT,
DESCRIPTION                  VARCHAR,
SERVICE_CATEGORY_ID              INT,
SERVICE_TYPE                 VARCHAR,
UNIT_TYPE_ID                     INT,
FREQUENCY_TYPE_ID                INT,
CODE_ID                          INT,
UNIT                    DECIMAL(7,2),
UNIT_COST               DECIMAL(7,2),
STATUS                           INT,
LAST_UPDATED_BY                  INT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
