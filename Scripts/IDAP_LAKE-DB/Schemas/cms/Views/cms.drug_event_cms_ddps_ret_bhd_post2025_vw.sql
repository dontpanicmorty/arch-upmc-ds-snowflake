CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_DDPS_RET_BHD_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                            AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                             AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 5)                                                           AS CONTRACT_NUMBER,
    SUBSTR(RECORD, 16, 3)                                                           AS PBP_ID,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(RECORD, 19, 8)),''),'YYYYMMDD')                  AS DDPS_SYSTEM_DATE,
    SUBSTR(RECORD, 27, 6)                                                           AS DDPS_SYSTEM_TIME,
    SUBSTR(RECORD, 33, 5)                                                           AS DDPS_REPORT_ID,
    SUBSTR(RECORD, 38, 475)                                                         AS FILLER,
    FILENAME                                                                        AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                     AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_DDPS_RETURN_STAGE
WHERE RECORD LIKE 'BHD%';