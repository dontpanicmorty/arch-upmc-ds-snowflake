!set variable_substitution=true;

CREATE OR REPLACE VIEW EPIC_EXTRACT.ACUITY_FINAL_ACTIVE_MEMBER_VW AS
WITH  MemberDemographics AS (
    SELECT 
         md.TPA_ID
        ,md.MEMBER_NBR
        ,md.MASTER_MEMBER_ID
        ,md.MEMBER_FULL_NAME
        ,md.MEMBER_LAST_NAME
        ,md.MEMBER_FIRST_NAME
        ,md.MEMBER_MIDDLE_NAME
        ,md.MEMBER_BIRTH_DATE 
        ,md.MEMBER_AGE
        ,md.GENDER_CODE
        ,ROW_NUMBER() OVER (
            PARTITION BY md.MASTER_MEMBER_ID
            ORDER BY  md.MEMBER_NBR
        ) AS rn
    FROM &{IDAP}.DIMDATA.DIM_MEMBER_VW md
    INNER JOIN &{IDAP}.DIMDATA.FACT_ENROLLMENT_VW e
        ON e.dim_member_key = md.dim_member_key
    WHERE md.TPA_DIV_ID = '0001' 
       AND (e.eligibility_end_date is null
             OR e.eligibility_end_date = '9999-12-31'
             OR  e.eligibility_end_date >= LAST_DAY(CURRENT_DATE(), 'YEAR'))
 ORDER BY MASTER_MEMBER_ID
 ) ,
         RankedAcuity AS (
            SELECT 
                 a.MMI
                ,a.LOAD_DATE
                ,a.health_acuity_tier_desc
                ,a.index_date
                ,ROW_NUMBER() OVER (
                    PARTITION BY a.MMI
                    ORDER BY a.index_date DESC
                ) AS rn
            FROM &{IDW}.ADL_PROD.MOD_HEALTH_ACUITY a
         )


 SELECT 
         ra.MMI
        ,d.MEMBER_FULL_NAME
        ,d.MEMBER_FIRST_NAME
        ,d.MEMBER_LAST_NAME
        , CASE 
            WHEN d.MEMBER_MIDDLE_NAME = 'UNKNOWN' THEN NULL
            ELSE d.MEMBER_MIDDLE_NAME
        END AS MEMBER_MIDDLE_NAME
        ,d.GENDER_CODE
        ,TO_VARCHAR(d.MEMBER_BIRTH_DATE, 'YYYYMMDD') AS MEMBER_BIRTH_DATE
        ,TO_VARCHAR(ra.LOAD_DATE, 'YYYYMMDDHH24MISS') AS LOAD_DATE
        ,ra.health_acuity_tier_desc
 FROM RankedAcuity ra
 INNER JOIN MemberDemographics d
        ON ra.mmi = d.MASTER_MEMBER_ID
WHERE d.rn = 1  
 AND ra.rn = 1
Order by ra.mmi;

!set variable_substitution=false;