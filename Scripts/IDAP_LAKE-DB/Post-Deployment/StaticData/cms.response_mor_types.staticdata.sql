MERGE INTO CMS.RESPONSE_MOR_TYPES AS TGT
USING (
    SELECT
        RECORD_TYPE_CODE    
        ,REPORT_SEGMENT_VIEW_NAME
        ,RECORD_TYPE_DESC
        ,FILE_TYPE 
        ,PLAN_YEAR_RANGE_START
        ,PLAN_YEAR_RANGE_END
    FROM
    (VALUES
     ('1','MOR_HCC_HEADER_VW'      ,'HCC Header Record','HCCMODD',NULL,NULL)
    ,('B','MOR_HCC_V21_PTC_BEG_VW' ,'Details for V21 PTC MOR (PACE ESRD only) (RAPS, FFS, and Encounter data)','HCCMODD','2012','2025')
    ,('E','MOR_HCC_V21_PTC_BEG_VW' ,'Details for V21 PTC MOR (ESRD) (RAPS and FFS)','HCCMODD','2012','2021')
    ,('G','MOR_HCC_V21_PTC_BEG_VW' ,'Details for V21 PTC MOR (ESRD) (Encounter and FFS)','HCCMODD','2012','2022')
    ,('C','MOR_HCC_V22_PTC_CF_VW'  ,'Details for V22 PTC MOR (RAPS and FFS) - non-PACE and non-ESRD','HCCMODD','2014','2016')
    ,('F','MOR_HCC_V22_PTC_CF_VW'  ,'Details for V22 PTC MOR (Encounter Data and FFS) - non-PACE and non-ESRD','HCCMODD','2014','2016')
    ,('D','MOR_HCC_V22_PTC_D_VW'   ,'Details for V22 PTC model MOR (RAPS and FFS) - non-PACE and non-ESRD','HCCMODD','2017','2021')
    ,('I','MOR_HCC_V23_PTC_I_VW'   ,'Details for V23 PTC MOR - non-PACE and non-ESRD benes','HCCMODD','2019','2019')
    ,('J','MOR_HCC_V24_PTC_J_VW'   ,'Details for V24 PTC MOR - non-PACE and non-ESRD benes','HCCMODD','2020','2025')
    ,('K','MOR_HCC_V22_PTC_K_VW'   ,'Details for V22 PTC MOR PACE non-ESRD beneficiaries','HCCMODD','2020','2025')
    ,('L','MOR_HCC_V24_PTC_L_VW'   ,'Details for V24 PTC ESRD beneficiaries (Encounter and FFS)','HCCMODD','2023','2025')
    ,('M','MOR_HCC_V28_PTC_M_VW'   ,'Details for V28 MOR - non-PACE and non-ESRD beneficiaries','HCCMODD','2024','2025')
    ,('3','MOR_HCC_TRAILER_VW'     ,'HCC Trailer Record','HCCMODD',NULL,NULL)    
    ,('1','MOR_RXHCC_HEADER_VW'    ,'PTD Header Record','PTDMODD',NULL,NULL)    
    ,('2','MOR_RXHCC_PTD_2_VW'     ,'Part D MOR Record Type 2 RxHCC beneficiary PY2017 through PY2021','PTDMODD','2017','2021')
    ,('4','MOR_RXHCC_PTD_4_VW'     ,'Part D MOR Record Type 4 RxHCC beneficiary PY2017 through PY2022','PTDMODD','2017','2022')
    ,('5','MOR_RXHCC_PTD_5_VW'     ,'Part D MOR Record Type 5 RxHCC beneficiary PY2017 through PY2024','PTDMODD','2017','2024')
    ,('6','MOR_RXHCC_PTD_6_VW'     ,'Part D MOR Record Type 6 (RxHCC Detail) - Non-PACE PY2023-PY2025, PACE+Non-PACE PY2026+','PTDMODD','2023',NULL)
    ,('7','MOR_RXHCC_PTD_7_VW'     ,'Part D MOR Record Type 7 (RxHCC Detail) - Pace RxHCC beneficiary','PTDMODD','2025',NULL)
    ,('3','MOR_RXHCC_TRAILER_VW'   ,'PTD Trailer Record','PTDMODD',NULL,NULL)
    ) static_data (
        RECORD_TYPE_CODE    
        ,REPORT_SEGMENT_VIEW_NAME
        ,RECORD_TYPE_DESC
        ,FILE_TYPE 
        ,PLAN_YEAR_RANGE_START
        ,PLAN_YEAR_RANGE_END
    )
) as SRC ON SRC.RECORD_TYPE_CODE = TGT.RECORD_TYPE_CODE AND SRC.FILE_TYPE = TGT.FILE_TYPE
WHEN NOT MATCHED THEN
    INSERT(RECORD_TYPE_CODE,REPORT_SEGMENT_VIEW_NAME,RECORD_TYPE_DESC,FILE_TYPE,PLAN_YEAR_RANGE_START,PLAN_YEAR_RANGE_END)
    VALUES(RECORD_TYPE_CODE,REPORT_SEGMENT_VIEW_NAME,RECORD_TYPE_DESC,FILE_TYPE,PLAN_YEAR_RANGE_START,PLAN_YEAR_RANGE_END)
;