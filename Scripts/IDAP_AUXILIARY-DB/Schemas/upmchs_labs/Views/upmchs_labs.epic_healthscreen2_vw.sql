!set variable_substitution=true;
CREATE OR REPLACE VIEW UPMCHS_LABS.EPIC_HEALTHSCREEN2_VW AS (
    SELECT DISTINCT
    HSP_ACCOUNT_ID                                                          AS ACCT_NBR,
    UPPER(PAT_LAST_NAME || ' ' || PAT_FIRST_NAME || ' ' || PAT_MIDDLE_NAME) AS FULL_NAME,
    PAT_MRN_ID                                                              AS MRN,
    LOC_NAME                                                                AS HOSP,
    REPLACE(REPLACE(REPLACE(ACC_NUM, '_ZY00',''), 'ZY01',''), '_','')       AS ACC_NBR,
    CAST(COMP_ANL_INST_TM AS DATE)                                          AS EVENT_DATE,
    TO_CHAR(COMP_ANL_INST_TM, 'HH24:MI')                                    AS EVENT_TIME,
    PROC_CODE                                                               AS BAT_CODE,
    COMPONENT_ID                                                            AS LAB_CODE,
    LOC_NAME                                                                AS FACILITY,
    REFERENCE_UNIT                                                          AS LAB_UNITS,
    LAB_RANGE,
    RESULT_FLAG,
    LAB_STATUS                                                              AS STATUS,
    '"'||ORD_VALUE||'"'                                                     AS LAB_RESULT
    FROM &{IDAP_LAKE}.LAB.EPIC_MARS
);
!set variable_substitution=false;
