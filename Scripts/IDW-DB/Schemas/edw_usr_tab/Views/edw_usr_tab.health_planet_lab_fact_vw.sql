!set variable_substitution=true;
CREATE OR REPLACE VIEW EDW_USR_TAB.HEALTH_PLANET_LAB_FACT_VW
(
    PANEL_NAME,
    MEMBER_NBR,
    SERVICE_DATE,
    PROVIDER_KEY,
    PROVIDER_NAME,
    TEST_CODE,
    TEST_NAME,
    RESULT_VALUE,
    RESULT_RANGE,
    RESULT_RANGE_LOW,
    RESULT_RANGE_HIGH,
    RESULT_UNITS,
    LOAD_DATE,
    UPDATE_DATE,
    SOURCE
)
AS
    SELECT g.PANEL_NAME,
           m.Member_NBR,
           lf.SERVICE_DATE,
           PR.PROVIDER_KEY,
           PR.PROVIDER_NAME,
           LT.LOINC_CODE           TEST_CODE,
           LT.LOINC_DESC_SHORT     TEST_NAME,
           --P.CPT4_Code ,
           --P.CPT4_DESC,
           lf.RESULT_VALUE,
           lr.RESULT_RANGE,
           lr.RESULT_RANGE_LOW,
           lr.RESULT_RANGE_HIGH,
           lr.RESULT_UNITS,
           lf.LOAD_DATE,
           lf.UPDATE_DATE,
           'EDW_RPT.LAB_FACT'      SOURCE
      FROM &{IDW_LAKE}.EDW_RPT.LAB_FACT  lf
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LAB_GROUPING g
               ON g.LAB_FACT_KEY = lf.LAB_FACT_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.MEMBER_RESTRICTED m
               ON m.Member_Key = lf.Member_key
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LOINC_TEST LT
               ON LT.LOINC_TEST_KEY = LF.LOINC_TEST_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LAB_Result_Range LR
               ON LR.LAB_RESULT_RANGE_KEY = lf.LAB_RESULT_RANGE_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.CPT4_PROCEDURE P
               ON P.CPT4_PROCEDURE_KEY = LF.CPT4_PROCEDURE_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.PROVIDER PR
               ON PR.PROVIDER_KEY = LF.PROVIDER_KEY
     WHERE     --lf.loinc_order <> 999
               UPPER (lf.result_value) <> 'DNR'
           AND UPPER (lf.result_value) <> 'UNKNOWN'
    UNION ALL
    SELECT g.PANEL_NAME,
           m.Member_NBR,
           lf.SERVICE_DATE,
           PR.PROVIDER_KEY,
           PR.PROVIDER_NAME,
           LT.LOINC_CODE             TEST_CODE,
           LT.LOINC_DESC_SHORT       TEST_NAME,
           --P.CPT4_Code ,
           --P.CPT4_DESC,
           lf.RESULT_VALUE,
           lr.RESULT_RANGE,
           lr.RESULT_RANGE_LOW,
           lr.RESULT_RANGE_HIGH,
           lr.RESULT_UNITS,
           lf.LOAD_DATE,
           lf.UPDATE_DATE,
           'EDW_RPT.MA_LAB_FACT'     SOURCE
      FROM &{IDW_LAKE}.EDW_RPT.MA_LAB_FACT  lf
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.MA_LAB_GROUPING g
               ON g.MA_LAB_FACT_KEY = lf.MA_LAB_FACT_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.MA_MEMBER m
               ON m.MA_Member_Key = lf.MA_MEMBER_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LOINC_TEST LT
               ON LT.LOINC_TEST_KEY = LF.LOINC_TEST_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LAB_Result_Range LR
               ON LR.LAB_RESULT_RANGE_KEY = lf.LAB_RESULT_RANGE_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.CPT4_PROCEDURE P
               ON P.CPT4_PROCEDURE_KEY = LF.CPT4_PROCEDURE_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.PROVIDER PR
               ON PR.PROVIDER_KEY = LF.PROVIDER_KEY
     WHERE     --lf.loinc_order <> 999
               UPPER (lf.result_value) <> 'DNR'
           AND UPPER (lf.result_value) <> 'UNKNOWN'
    UNION ALL
    SELECT g.PANEL_NAME,
           m.Member_NBR,
           lf.SERVICE_DATE,
           PR.PROVIDER_KEY,
           PR.PROVIDER_NAME,
           LT.LOINC_CODE             TEST_CODE,
           LT.LOINC_DESC_SHORT       TEST_NAME,
           --P.CPT4_Code ,
           --P.CPT4_DESC,
           lf.RESULT_VALUE,
           lr.RESULT_RANGE,
           lr.RESULT_RANGE_LOW,
           lr.RESULT_RANGE_HIGH,
           lr.RESULT_UNITS,
           lf.LOAD_DATE,
           lf.UPDATE_DATE,
           'EDW_RPT.MC_LAB_FACT'     SOURCE
      FROM &{IDW_LAKE}.EDW_RPT.MC_LAB_FACT  lf
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.MC_LAB_GROUPING g
               ON g.MC_LAB_FACT_KEY = lf.MC_LAB_FACT_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.MC_MEMBER m
               ON m.MC_Member_Key = lf.MC_MEMBER_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LOINC_TEST LT
               ON LT.LOINC_TEST_KEY = LF.LOINC_TEST_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.LAB_Result_Range LR
               ON LR.LAB_RESULT_RANGE_KEY = lf.LAB_RESULT_RANGE_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.CPT4_PROCEDURE P
               ON P.CPT4_PROCEDURE_KEY = LF.CPT4_PROCEDURE_KEY
           LEFT OUTER JOIN &{IDW_LAKE}.EDW_RPT.PROVIDER PR
               ON PR.PROVIDER_KEY = LF.PROVIDER_KEY
     WHERE     --lf.loinc_order <> 999
               UPPER (lf.result_value) <> 'DNR'
           AND UPPER (lf.result_value) <> 'UNKNOWN'
           AND lf.result_value <> 'unknown';
!set variable_substitution=false;
