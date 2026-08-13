CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_ICD_DIAGNOSIS_CATEGORY_MC400UPM_SELECT_VW
AS

WITH DIAGNOSIS_CODES_CTE
AS
(
SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, DIAGNONIS_CODE  --List of distinct diagnosis codes that exist on claims.
FROM (SELECT TpaClient, TpaIdOfClient, TpaDivision
    //set any blank diagnosis codes to null so they are automatically excluded from the UNPIVOT
    ,IFF(TRIM(Diagnosis1) = '',NULL,Diagnosis1) as Diagnosis1
    ,IFF(TRIM(Diagnosis2) = '',NULL,Diagnosis2) as Diagnosis2
    ,IFF(TRIM(Diagnosis3) = '',NULL,Diagnosis3) as Diagnosis3
    ,IFF(TRIM(Diagnosis4) = '',NULL,Diagnosis4) as Diagnosis4
    ,IFF(TRIM(Diagnosis5) = '',NULL,Diagnosis5) as Diagnosis5
    ,IFF(TRIM(Diagnosis6) = '',NULL,Diagnosis6) as Diagnosis6
    ,IFF(TRIM(Diagnosis7) = '',NULL,Diagnosis7) as Diagnosis7
    ,IFF(TRIM(Diagnosis8) = '',NULL,Diagnosis8) as Diagnosis8
    ,IFF(TRIM(Diagnosis9) = '',NULL,Diagnosis9) as Diagnosis9
    ,IFF(TRIM(Diagnosis10) = '',NULL,Diagnosis10) as Diagnosis10
    ,IFF(TRIM(Diagnosis11) = '',NULL,Diagnosis11) as Diagnosis11
    ,IFF(TRIM(Diagnosis12) = '',NULL,Diagnosis12) as Diagnosis12
    ,IFF(TRIM(Diagnosis13) = '',NULL,Diagnosis13) as Diagnosis13
    ,IFF(TRIM(Diagnosis14) = '',NULL,Diagnosis14) as Diagnosis14
    ,IFF(TRIM(Diagnosis15) = '',NULL,Diagnosis15) as Diagnosis15
    ,IFF(TRIM(Diagnosis16) = '',NULL,Diagnosis16) as Diagnosis16
    ,IFF(TRIM(Diagnosis17) = '',NULL,Diagnosis17) as Diagnosis17
    ,IFF(TRIM(Diagnosis18) = '',NULL,Diagnosis18) as Diagnosis18
    ,IFF(TRIM(Diagnosis19) = '',NULL,Diagnosis19) as Diagnosis19
    ,IFF(TRIM(Diagnosis20) = '',NULL,Diagnosis20) as Diagnosis20
    ,IFF(TRIM(Diagnosis21) = '',NULL,Diagnosis21) as Diagnosis21
    ,IFF(TRIM(Diagnosis22) = '',NULL,Diagnosis22) as Diagnosis22
    ,IFF(TRIM(Diagnosis23) = '',NULL,Diagnosis23) as Diagnosis23
    ,IFF(TRIM(Diagnosis24) = '',NULL,Diagnosis24) as Diagnosis24
    ,IFF(TRIM(Diagnosis25) = '',NULL,Diagnosis25) as Diagnosis25
    ,IFF(TRIM(Diagnosis26) = '',NULL,Diagnosis26) as Diagnosis26
    ,IFF(TRIM(Diagnosis27) = '',NULL,Diagnosis27) as Diagnosis27
    ,IFF(TRIM(Diagnosis28) = '',NULL,Diagnosis28) as Diagnosis28
    ,IFF(TRIM(Diagnosis29) = '',NULL,Diagnosis29) as Diagnosis29
    ,IFF(TRIM(Diagnosis30) = '',NULL,Diagnosis30) as Diagnosis30
    ,IFF(TRIM(Diagnosis31) = '',NULL,Diagnosis31) as Diagnosis31
    ,IFF(TRIM(Diagnosis32) = '',NULL,Diagnosis32) as Diagnosis32
    ,IFF(TRIM(Diagnosis33) = '',NULL,Diagnosis33) as Diagnosis33
    ,IFF(TRIM(Diagnosis34) = '',NULL,Diagnosis34) as Diagnosis34
    ,IFF(TRIM(Diagnosis35) = '',NULL,Diagnosis35) as Diagnosis35
    ,IFF(TRIM(Diagnosis36) = '',NULL,Diagnosis36) as Diagnosis36
    ,IFF(TRIM(Diagnosis37) = '',NULL,Diagnosis37) as Diagnosis37
    ,IFF(TRIM(Diagnosis38) = '',NULL,Diagnosis38) as Diagnosis38
    ,IFF(TRIM(Diagnosis39) = '',NULL,Diagnosis39) as Diagnosis39
    ,IFF(TRIM(Diagnosis40) = '',NULL,Diagnosis40) as Diagnosis40
    ,IFF(TRIM(Diagnosis41) = '',NULL,Diagnosis40) as Diagnosis41
    FROM RAWDATA.MC400_DWOAO_CLAIMS
    WHERE MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
    ) DIAGNOSIS_CODES_FLAT
        UNPIVOT (DIAGNONIS_CODE FOR COLUMN_NAME IN
            (Diagnosis1,Diagnosis2,Diagnosis3,Diagnosis4,Diagnosis5,Diagnosis6,Diagnosis7,Diagnosis8,Diagnosis9,Diagnosis10
            ,Diagnosis11,Diagnosis12,Diagnosis13,Diagnosis14,Diagnosis15,Diagnosis16,Diagnosis17,Diagnosis18,Diagnosis19,Diagnosis20
            ,Diagnosis21,Diagnosis22,Diagnosis23,Diagnosis24,Diagnosis25,Diagnosis26,Diagnosis27,Diagnosis28,Diagnosis29,Diagnosis30
            ,Diagnosis31,Diagnosis32,Diagnosis33,Diagnosis34,Diagnosis35,Diagnosis36,Diagnosis37,Diagnosis38,Diagnosis39,Diagnosis40
            ,Diagnosis41)
            )
) -- END CTE

-- This is the select to get the data
SELECT
CATEGORY_CODE_LIST.TpaClient AS TPA_CLIENT_ID
,CATEGORY_CODE_LIST.TpaIdOfClient AS TPA_ID
,CATEGORY_CODE_LIST.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,DiagnosisTypes.DiagnosisType AS CODE
,TRIM(DiagnosisTypes.Description) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CODE]) AS CLAIM_ICD_DIAGNOSIS_CATEGORY_HKEY
FROM (
    SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, CATEGORY_CODE -- Get a distinct list of the category codes that exist across all the diagnosis codes
    FROM (SELECT //set any blank category codes to null so they are automatically excluded from the UNPIVOT
        DiagnosisCodes.TpaClient, DiagnosisCodes.TpaIdOfClient, DiagnosisCodes.TpaDivision
        ,IFF(TRIM(DiagnosisCodes.CodeCategory1) = '', NULL, DiagnosisCodes.CodeCategory1) AS CodeCategory1
        ,IFF(TRIM(DiagnosisCodes.CodeCategory2) = '', NULL, DiagnosisCodes.CodeCategory2) AS CodeCategory2
        ,IFF(TRIM(DiagnosisCodes.CodeCategory3) = '', NULL, DiagnosisCodes.CodeCategory3) AS CodeCategory3
        ,IFF(TRIM(DiagnosisCodes.CodeCategory4) = '', NULL, DiagnosisCodes.CodeCategory4) AS CodeCategory4
        ,IFF(TRIM(DiagnosisCodes.CodeCategory5) = '', NULL, DiagnosisCodes.CodeCategory5) AS CodeCategory5
        FROM RAWDATA.MC400_DWOAO_DIAGNOSISCODES DiagnosisCodes
        WHERE DiagnosisCodes.DeletedFlag = '1900-01-01 00:00:00.000'
        AND DiagnosisCodes.Code IN (SELECT DIAGNONIS_CODE FROM DIAGNOSIS_CODES_CTE)
        ) CATEGORY_CODES_FLAT
            UNPIVOT (CATEGORY_CODE FOR COLUMN_NAME IN 
                        (CodeCategory1 ,CodeCategory2 ,CodeCategory3 ,CodeCategory4 ,CodeCategory5)
                    )
    ) CATEGORY_CODE_LIST
        JOIN RAWDATA.MC400_DWOAO_DIAGNOSISTYPES DiagnosisTypes
            ON (DiagnosisTypes.DiagnosisType = CATEGORY_CODE_LIST.CATEGORY_CODE)
;
