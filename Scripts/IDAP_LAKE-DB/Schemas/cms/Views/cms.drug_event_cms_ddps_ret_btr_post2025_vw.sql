CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_DDPS_RET_BTR_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                            AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                             AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 5)                                                           AS CONTRACT_NUMBER,
    SUBSTR(RECORD, 16, 3)                                                           AS PBP_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 19, 7))                                            AS DET_RECORD_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 26, 7))                                            AS DET_ACCEPTED_RECORD_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 33, 7))                                            AS DET_INFORMATIONAL_RECORD_TOTAL,
    TRY_TO_NUMBER(SUBSTR(RECORD, 40, 7))                                            AS DET_REJECTED_RECORD_TOTAL,
    SUBSTR(RECORD, 47, 466)                                                         AS FILLER,
    FILENAME                                                                        AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                     AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_DDPS_RETURN_STAGE
WHERE RECORD LIKE 'BTR%';