!set variable_substitution=true;
CREATE OR REPLACE VIEW EPIC_EXTRACT.HCC_FINAL_ACTIVE_MEMBER_VW AS
 SELECT 
         d.MASTER_MEMBER_ID
        ,d.MEMBER_FULL_NAME
        ,d.MEMBER_FIRST_NAME
        ,d.MEMBER_LAST_NAME
        ,CASE 
                    WHEN d.MEMBER_MIDDLE_NAME = 'UNKNOWN' THEN null
                    ELSE d.MEMBER_MIDDLE_NAME
                 END AS MEMBER_MIDDLE_NAM
        ,d.GENDER_CODE
        ,TO_VARCHAR(d.MEMBER_BIRTH_DATE, 'YYYYMMDD') AS MEMBER_BIRTH_DATE
        ,TO_VARCHAR(h.LOAD_DATE, 'YYYYMMDDHH24MISS') AS LOAD_DATE
        ,h.MEMBER_NBR
        ,h.COUNT_HCC
        ,h.HCC_MODEL
        ,h.HCC_CONDITION
        ,h.HCC_DESCRIPTION
        ,h.ICD10_CM
        ,h.DIAGNOSIS_DESCRIPTION
        ,h.DIAGNOSIS_DISPLAY_RANK
 FROM &{IDW}.HCC_USER.HEALTHPLANET_OPEN_HCC h
 INNER JOIN &{IDAP}.DIMDATA.DIM_MEMBER_VW d
        ON h. MEMBER_NBR = d. MEMBER_NBR
 INNER JOIN &{IDAP}.DIMDATA.FACT_ENROLLMENT_VW e
        ON e.dim_member_key = d.dim_member_key
 WHERE d.TPA_DIV_ID = '0001' 
       AND (e.eligibility_end_date is null
             OR e.eligibility_end_date = '9999-12-31'
             OR  e.eligibility_end_date >= LAST_DAY(CURRENT_DATE(), 'YEAR'))
 ORDER BY MASTER_MEMBER_ID
;

!set variable_substitution=false;