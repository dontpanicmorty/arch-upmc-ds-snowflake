CREATE OR REPLACE VIEW CMS.PARTD_EXCLUSION_WARNING_PEXBH_CURRENT_VW AS
SELECT
    FILENAME                                                            AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                         AS INSERT_DATETIME,
    SUBSTR(RECORD,1,5)                                                  AS RECORD_ID,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(RECORD, 6, 8)),''),'YYYYMMDD')       AS DDPS_SYSTEM_DATE,
    SUBSTR(RECORD,14,6)                                                 AS DDPS_SYSTEM_TIME,
    SUBSTR(RECORD,20,5)                                                 AS FILE_ID,
    SUBSTR(RECORD,25,4)                                                 AS RECON_BENEFIT_YEAR,
    SUBSTR(RECORD,29,4)                                                 AS RECON_NUM
FROM CMS.PARTD_EXCLUSION_WARNING_STAGE
WHERE SUBSTR(RECORD,1,5) = 'PEXBH';