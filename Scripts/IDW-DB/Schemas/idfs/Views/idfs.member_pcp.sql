!set variable_substitution=true;

CREATE OR REPLACE VIEW IDFS.MEMBER_PCP(
	MMI,
	EFFECTIVE_START_DATE,
	EFFECTIVE_END_DATE,
	FINAL_OFFICE_ID,
	FINAL_OFFICE_NAME,
	FINAL_TAX_ID_NBR
) AS 
    WITH INFO
        AS (
            SELECT  EDG.MMI,
                    MH.MEMBER_NBR,
                    MH.LOB,
                    MH.EFFECTIVE_START_DATE,
                    MH.EFFECTIVE_END_DATE,
                    MH.FINAL_OFFICE_ID,
                    MH.FINAL_OFFICE_NAME,
                    MH.FINAL_TAX_ID_NBR,
                    MH.MOST_RECENT_VISIT_DATE,
                    CASE WHEN FINAL_OFFICE_ID = 'NONE' THEN 2 ELSE 1 END
                        PRIORITY1,
                    CASE
                        WHEN MH.LOB = 'COMMERCIAL'
                        THEN
                            1
                        WHEN MH.LOB = 'MEDICARE' OR MH.LOB = 'MEDICARE_SNP'
                        THEN
                            2
                        WHEN MH.LOB = 'MEDICAID'
                        THEN
                            3
                        WHEN MH.LOB = 'CHIP'
                        THEN
                            4
                        WHEN MH.LOB LIKE '%CHC%'
                        THEN
                            5
                        ELSE
                            6
                    END
                        PRIORITY2
            FROM    EDW_USR_TAB.MEDICAL_HOME  MH
                INNER JOIN &{IDW_LAKE}.MEMBER_STAGING.EMPI_DAILY_GLOBAL EDG
                    ON MH.MEMBER_NBR = EDG.HEALTHPLAN_ID
            WHERE   MH.EFFECTIVE_END_DATE =
                    (SELECT MAX (EFFECTIVE_END_DATE)
                       FROM EDW_USR_TAB.MEDICAL_HOME
                      WHERE MEMBER_NBR = MH.MEMBER_NBR
                      )
            )
    --- APPLY HIERARCHY TO SELECT PREFERRED RECORD PER MASTER MEMBER ID

    SELECT MMI,
           EFFECTIVE_START_DATE,
           EFFECTIVE_END_DATE,
           FINAL_OFFICE_ID,
           FINAL_OFFICE_NAME,
           FINAL_TAX_ID_NBR
      FROM (SELECT I.*,
                   RANK ()
                       OVER (PARTITION BY MMI
                             ORDER BY
                                 PRIORITY1,
                                 PRIORITY2,
                                 EFFECTIVE_END_DATE DESC,
                                 EFFECTIVE_START_DATE,
                                 MOST_RECENT_VISIT_DATE DESC,
                                 MEMBER_NBR DESC)    AS RNK
              FROM INFO I)
     WHERE RNK = 1;

!set variable_substitution=true;