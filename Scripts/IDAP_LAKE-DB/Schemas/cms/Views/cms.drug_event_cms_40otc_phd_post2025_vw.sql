CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_40OTC_PHD_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                        AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                         AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 5)                                                       AS CONTRACT_NUMBER,
    SUBSTR(RECORD, 16, 3)                                                       AS PBP_ID,
    SUBSTR(RECORD, 19, 16)                                                      AS FILE_ID,
    SUBSTR(RECORD, 35, 4)                                                       AS PROD_TEST_IND,
    SUBSTR(RECORD, 39, 4)                                                       AS AS_OF_YEAR,
    SUBSTR(RECORD, 43, 2)                                                       AS AS_OF_MONTH,
    TRY_TO_DATE(NULLIF(TRIM(SUBSTR(RECORD, 45, 8)),''),'YYYYMMDD')              AS DDPS_SYSTEM_DATE,
    SUBSTR(RECORD, 53, 6)                                                       AS DDPS_SYSTEM_TIME,
    SUBSTR(RECORD, 59, 5)                                                       AS DDPS_REPORT_ID,
    SUBSTR(RECORD, 64, 449)                                                     AS FILLER,
    FILENAME                                                                    AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                 AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_40OTC_STAGE
WHERE RECORD LIKE 'PHD%';