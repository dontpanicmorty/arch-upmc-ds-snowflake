CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_DDPS_RET_TLR_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                            AS RECORD_ID,
    SUBSTR(RECORD, 4, 6)                                                            AS SUBMITTER_ID,
    SUBSTR(RECORD, 10, 10)                                                          AS FILE_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 20, 9))                                            AS TLR_BHD_RECORD_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 29, 9))                                            AS TLR_DET_RECORD_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 38, 9))                                            AS TLR_DET_ACCEPTED_RECORD_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 47, 9))                                            AS TLR_DET_INFORMATION_REC_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 56, 9))                                            AS TLR_DET_REJECTED_RECORD_TOTAL,
    SUBSTR(RECORD, 65, 448)                                                         AS FILLER,
    FILENAME                                                                        AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                     AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_DDPS_RETURN_STAGE
WHERE RECORD LIKE 'TLR%';