CREATE OR REPLACE TABLE VIRTUAL_HEALTH_STAGE.LETTER_CORRESPONDENCE
(
ID                              INT,
AUTHOR_ID                       INT,
FILENAME                    VARCHAR,
DOCUMENT_UUID               VARCHAR,
QUANTITY                        INT,
SEQ                             INT,
STATUS                      VARCHAR,
CREATED_DATE          TIMESTAMP_NTZ,
LETTERS_DATE          TIMESTAMP_NTZ,
REMOTE_LOCATION             VARCHAR,
GENERATION_PARAMS           VARIANT
)
COMMENT='Created for UPMCVH_PROD Migration'
;
