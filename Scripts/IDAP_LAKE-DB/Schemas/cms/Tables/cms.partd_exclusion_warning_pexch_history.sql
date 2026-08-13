CREATE OR REPLACE TABLE CMS.PARTD_EXCLUSION_WARNING_PEXCH_HISTORY
(
    FILENAME                                VARCHAR,
    INSERT_DATETIME                         TIMESTAMP_NTZ,
    RECORD_ID                               VARCHAR,
    SEQUENCE_NUMBER                         NUMBER,
    DDPS_SYSTEM_DATE                        DATE,
    DDPS_SYSTEM_TIME                        VARCHAR,
    FILE_ID                                 VARCHAR,
    CONTRACT                                VARCHAR
);