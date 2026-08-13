CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_41COV_DET_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                        AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                         AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 1)                                                       AS DRUG_COVERAGE_STATUS_CODE,
    NULL                                                                        AS CURRENT_CMS_HICN,  
    NULL                                                                        AS LAST_SUBMITTED_HICN, 
    SUBSTR(RECORD, 52, 20)                                                      AS LAST_SUBMITTED_CARDHOLDER_ID,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 72, 14))                                   AS CURR_MON_GDCB,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 86, 14))                                   AS CURR_MON_GDCA,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 100, 14))                                  AS CURR_MON_TOTAL_GROSS_DRUG_COST,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 114, 14))                                  AS CURR_MON_LICS_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 128, 14))                                  AS CURR_MON_CPP_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 142, 14))                                  AS CURR_MON_P2P_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 156, 14))                                  AS CURR_MON_SELE_DRUG_SUB_AMT,
    SUBSTR(RECORD, 170, 343)                                                    AS FILLER,
    FILENAME                                                                    AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                 AS INSERT_DATETIME,
    SUBSTR(RECORD, 12, 20)                                                      AS CURRENT_CMS_MBI,
    SUBSTR(RECORD, 32, 20)                                                      AS LAST_SUBMITTED_MBI
FROM CMS.DRUG_EVENT_41COV_STAGE
WHERE RECORD LIKE 'DET%';