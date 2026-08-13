CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_ERR_SUM_BTR_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                          AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                           AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 5)                                                         AS CONTRACT_NUMBER,
    SUBSTR(RECORD, 16, 3)                                                         AS PBP_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 19, 7))                                          AS DET_RECORD_TOTAL,
    SUBSTR(RECORD, 26, 487)                                                       AS FILLER,
    FILENAME                                                                      AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                   AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_ERROR_SUMMARY_STAGE
WHERE RECORD LIKE 'BTR%';