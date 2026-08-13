CREATE OR REPLACE VIEW CMS.PARTD_EXCLUSION_WARNING_PEXPH_CURRENT_VW AS
SELECT
    FILENAME                                                            AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                         AS INSERT_DATETIME,
    SUBSTR(RECORD,1,5)                                                  AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD,6,7))                                   AS SEQUENCE_NUMBER,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(RECORD, 13, 8)),''),'YYYYMMDD')      AS DDPS_SYSTEM_DATE,
    SUBSTR(RECORD,21,6)                                                 AS DDPS_SYSTEM_TIME,
    SUBSTR(RECORD,27,5)                                                 AS FILE_ID,
    SUBSTR(RECORD,32,5)                                                 AS CONTRACT,
    SUBSTR(RECORD,37,3)                                                 AS PBP
FROM CMS.PARTD_EXCLUSION_WARNING_STAGE
WHERE SUBSTR(RECORD,1,5) = 'PEXPH';