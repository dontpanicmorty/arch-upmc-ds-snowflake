CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_43COV_STR_POST2025_VW AS
SELECT DISTINCT
    SUBSTR(RECORD, 1, 3)                                                        AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                         AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 5)                                                       AS CONTRACT_NUMBER,
    SUBSTR(RECORD, 16, 3)                                                       AS FILLER,
    SUBSTR(RECORD, 19, 1)                                                       AS DRUG_COVERAGE_STATUS_CODE,
    TRY_TO_NUMBER(SUBSTR(RECORD, 20, 12))                                       AS BENEFICIARY_COUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 32, 14))                                   AS CURRENT_MONTH_GDCB_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 46, 14))                                   AS CURRENT_MONTH_GDCA_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 60, 14))                                   AS CURR_MON_TOTAL_GROSS_DRUG_COST,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 74, 14))                                   AS CURRENT_MONTH_LICS_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 88, 14))                                   AS CURRENT_MONTH_CPP_AMOUNT,
    TRY_TO_NUMBER(SUBSTR(RECORD, 102, 12))                                      AS DET_RECORD_TOTAL,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 114, 14))                                  AS CURR_MON_P2P_AMT_DUE_ALL_SUB,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 128, 14))                                  AS CURR_MON_SELE_DRUG_SUB_AMT,
    SUBSTR(RECORD, 142, 390)                                                    AS FILLER2,
    a.FILENAME                                                                  AS FILENAME,
    a.FILE_LAST_MODIFIED_DATETIME                                               AS INSERT_DATETIME,
    b.FILE_ID                                                                   AS CHD_FILE_ID,
    a.ROW_NUMBER                                                                AS ROW_ID
    FROM CMS.DRUG_EVENT_43COV_STAGE AS a
    INNER JOIN CMS.DRUG_EVENT_CMS_43COV_CHD_POST2025_VW AS b
    ON a.FILENAME= b.FILENAME
    WHERE RECORD LIKE 'STR%';