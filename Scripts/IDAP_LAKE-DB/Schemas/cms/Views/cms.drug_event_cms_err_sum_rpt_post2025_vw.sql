CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_ERR_SUM_RPT_POST2025_VW AS
SELECT
    SUBSTR(HEADER_APPENDED_RECORD, 1, 3)                                                   AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(HEADER_APPENDED_RECORD, 4, 7))                                    AS SEQUENCE_NUMBER,
    SUBSTR(HEADER_APPENDED_RECORD, 11, 3)                                                  AS ERROR_CODE,
    SUBSTR(HEADER_APPENDED_RECORD, 14, 350)                                                AS ERROR_CODE_DESCRIPTION,
    TRY_TO_NUMBER(SUBSTR(HEADER_APPENDED_RECORD, 364, 7))                                  AS FREQUENCY_OF_OCCURRENCE,
    CMS.FXN_OVERPUNCH(SUBSTR(HEADER_APPENDED_RECORD, 371, 4))                              AS PERCENTAGE_OF_ALL_EDITS,
    SUBSTR(HEADER_APPENDED_RECORD, 375, 138)                                               AS FILLER,
    FILENAME                                                                               AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                            AS INSERT_DATETIME,
    SUBSTR(HEADER_APPENDED_RECORD, 513, 3)                                                 AS RECORD_ID_BHD,
    TRY_TO_NUMBER(SUBSTR(HEADER_APPENDED_RECORD, 516, 7))                                  AS BATCH_SEQUENCE_NUMBER_BHD,
    SUBSTR(HEADER_APPENDED_RECORD, 523, 5)                                                 AS CONTRACT_NUMBER_BHD,
    SUBSTR(HEADER_APPENDED_RECORD, 528, 3)                                                 AS PBP_ID_BHD,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(HEADER_APPENDED_RECORD, 531, 8)),''),'YYYYMMDD')        AS DDPS_SYSTEM_DATE_BHD,
    SUBSTR(HEADER_APPENDED_RECORD, 539, 6)                                                 AS DDPS_SYSTEM_TIME_BHD,
    SUBSTR(HEADER_APPENDED_RECORD, 545, 5)                                                 AS DDPS_REPORT_ID_BHD,
    SUBSTR(HEADER_APPENDED_RECORD, 550, 475)                                               AS FILLER_BHD
FROM CMS.DRUG_EVENT_ERROR_SUMMARY_STAGE
WHERE HEADER_APPENDED_RECORD LIKE 'DET%';