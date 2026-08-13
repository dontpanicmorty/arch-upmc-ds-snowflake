CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_42COV_CTR_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                        AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                         AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 5)                                                       AS CONTRACT_NUMBER,
    SUBSTR(RECORD, 16, 1)                                                       AS DRUG_COVERAGE_STATUS_CODE,
    TRY_TO_NUMBER(SUBSTR(RECORD, 17, 12))                                       AS BENEFICIARY_COUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 38, 14))                                   AS NET_GDCB,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 52, 14))                                   AS NET_GDCA,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 66, 14))                                   AS NET_TOTAL_GROSS_DRUG_COST,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 80, 14))                                   AS NET_LICS_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 94, 14))                                   AS NET_CPP_AMOUNT,
    TRY_TO_NUMBER(SUBSTR(RECORD, 108, 12))                                      AS DET_RECORD_TOTAL,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 120, 14))                                  AS P2P_AMT_DUE_ALL_SUBMIT_CON,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 134, 14))                                  AS NET_SELE_DRUG_SUB_AMT,
    SUBSTR(RECORD, 148, 384)                                                    AS FILLER,
    FILENAME                                                                    AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                 AS INSERT_DATETIME
FROM CMS.DRUG_EVENT_42COV_STAGE
WHERE RECORD LIKE 'CTR%';