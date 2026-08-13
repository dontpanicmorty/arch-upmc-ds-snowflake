CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_DDPS_RET_HDR_POST2025_VW AS
SELECT DISTINCT
    SUBSTR(RECORD, 1, 3)                                                            AS RECORD_ID,
    SUBSTR(RECORD, 4, 6)                                                            AS SUBMITTER_ID,
    SUBSTR(RECORD, 10, 10)                                                          AS FILE_ID,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(RECORD, 20, 8)),''),'YYYYMMDD')                  AS TRANS_DATE,
    SUBSTR(RECORD, 28, 4)                                                           AS PROD_TEST_IND,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(RECORD, 32, 8)),''),'YYYYMMDD')                  AS DDPS_SYSTEM_DATE,
    SUBSTR(RECORD, 40, 6)                                                           AS DDPS_SYSTEM_TIME,
    SUBSTR(RECORD, 46, 5)                                                           AS DDPS_REPORT_ID,
    SUBSTR(RECORD, 51, 462)                                                         AS FILLER,
    FILENAME                                                                        AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                     AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_DDPS_RETURN_STAGE
WHERE RECORD LIKE 'HDR%';