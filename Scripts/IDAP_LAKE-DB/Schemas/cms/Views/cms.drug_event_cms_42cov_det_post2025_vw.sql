CREATE OR REPLACE VIEW CMS.DRUG_EVENT_CMS_42COV_DET_POST2025_VW AS
SELECT
    SUBSTR(RECORD, 1, 3)                                                        AS RECORD_ID,
    TRY_TO_NUMBER(SUBSTR(RECORD, 4, 7))                                         AS SEQUENCE_NUMBER,
    SUBSTR(RECORD, 11, 1)                                                       AS DRUG_COVERAGE_STATUS_CODE,
    NULL                                                                        AS CURRENT_CMS_HICN,
    NULL                                                                        AS LAST_SUBMITTED_HICN,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 52, 14))                                   AS NET_GDCB,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 66, 14))                                   AS NET_GDCA,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 80, 14))                                   AS NET_TOTAL_GROSS_DRUG_COST,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 94, 14))                                   AS NET_LICS_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 108, 14))                                  AS NET_CPP_AMOUNT,
    SUBSTR(RECORD, 122, 5)                                                      AS P2P_CONTRACT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 127, 14))                                  AS P2P_AMOUNT,
    CMS.FXN_OVERPUNCH(SUBSTR(RECORD, 141, 14))                                  AS NET_SELE_DRUG_SUB_AMT,
    SUBSTR(RECORD, 155, 372)                                                    AS FILLER,
    FILENAME                                                                    AS FILENAME,
    FILE_LAST_MODIFIED_DATETIME                                                 AS INSERT_DATETIME,
    SUBSTR(RECORD, 12, 20)                                                      AS CURRENT_CMS_MBI,
    SUBSTR(RECORD, 32, 20)                                                      AS LAST_SUBMITTED_MBI
FROM CMS.DRUG_EVENT_42COV_STAGE
WHERE RECORD LIKE 'DET%';