
CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_ICD_PROCEDURE_MC400UPM_SELECT_VW
AS
WITH PROCEDURE_CODES_CTE
AS
(
SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, PROCEDURE_CODE  --List of distinct Surgical codes that exist on claims.
FROM (SELECT TpaClient, TpaIdOfClient, TpaDivision
    //set any blank Surgical codes to null so they are automatically excluded from the UNPIVOT
    ,IFF(TRIM(Surgical1) = '',NULL,Surgical1) as Surgical1
    ,IFF(TRIM(Surgical2) = '',NULL,Surgical2) as Surgical2
    ,IFF(TRIM(Surgical3) = '',NULL,Surgical3) as Surgical3
    ,IFF(TRIM(Surgical4) = '',NULL,Surgical4) as Surgical4
    ,IFF(TRIM(Surgical5) = '',NULL,Surgical5) as Surgical5
    ,IFF(TRIM(Surgical6) = '',NULL,Surgical6) as Surgical6
    ,IFF(TRIM(Surgical7) = '',NULL,Surgical7) as Surgical7
    ,IFF(TRIM(Surgical8) = '',NULL,Surgical8) as Surgical8
    ,IFF(TRIM(Surgical9) = '',NULL,Surgical9) as Surgical9
    ,IFF(TRIM(Surgical10) = '',NULL,Surgical10) as Surgical10
    ,IFF(TRIM(Surgical11) = '',NULL,Surgical11) as Surgical11
    ,IFF(TRIM(Surgical12) = '',NULL,Surgical12) as Surgical12
    ,IFF(TRIM(Surgical13) = '',NULL,Surgical13) as Surgical13
    ,IFF(TRIM(Surgical14) = '',NULL,Surgical14) as Surgical14
    ,IFF(TRIM(Surgical15) = '',NULL,Surgical15) as Surgical15
    ,IFF(TRIM(Surgical16) = '',NULL,Surgical16) as Surgical16
    ,IFF(TRIM(Surgical17) = '',NULL,Surgical17) as Surgical17
    ,IFF(TRIM(Surgical18) = '',NULL,Surgical18) as Surgical18
    ,IFF(TRIM(Surgical19) = '',NULL,Surgical19) as Surgical19
    ,IFF(TRIM(Surgical20) = '',NULL,Surgical20) as Surgical20
    ,IFF(TRIM(Surgical21) = '',NULL,Surgical21) as Surgical21
    ,IFF(TRIM(Surgical22) = '',NULL,Surgical22) as Surgical22
    ,IFF(TRIM(Surgical23) = '',NULL,Surgical23) as Surgical23
    ,IFF(TRIM(Surgical24) = '',NULL,Surgical24) as Surgical24
    ,IFF(TRIM(Surgical25) = '',NULL,Surgical25) as Surgical25
    FROM RAWDATA.MC400_DWOAO_CLAIMS
    WHERE MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
    ) PROCEDURE_CODES_FLAT
        UNPIVOT (PROCEDURE_CODE FOR COLUMN_NAME IN
            (Surgical1,Surgical2,Surgical3,Surgical4,Surgical5,Surgical6,Surgical7,Surgical8,Surgical9,Surgical10
            ,Surgical11,Surgical12,Surgical13,Surgical14,Surgical15,Surgical16,Surgical17,Surgical18,Surgical19,Surgical20
            ,Surgical21,Surgical22,Surgical23,Surgical24,Surgical25)
            )
) -- END CTE

SELECT
DiagnosisCodes.TpaClient AS TPA_CLIENT_ID
,DiagnosisCodes.TpaIdOfClient AS TPA_ID
,DiagnosisCodes.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,STAGEDATA.FXN_GET_ICD_GROUP_VERSION(DATA_SOURCE_NAME, DiagnosisCodes.IcdVersionCode, DiagnosisCodes.Code) AS ICD_INFO
,ICD_INFO:"icdVersion"::string AS CODE_VERSION
,PROCEDURE_CODES_CTE.PROCEDURE_CODE AS CODE
,DiagnosisCodes.Description AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,ICD_INFO:"icdGroupCode"::string AS GROUP_CODE
,NULL AS GROUP_DESC
,ARRAY_CONSTRUCT_COMPACT
    (
    (IFF(TRIM(DiagnosisCodes.CodeCategory1) = '', NULL, DiagnosisCodes.CodeCategory1))
    ,(IFF(TRIM(DiagnosisCodes.CodeCategory2) = '', NULL, DiagnosisCodes.CodeCategory2))
    ,(IFF(TRIM(DiagnosisCodes.CodeCategory3) = '', NULL, DiagnosisCodes.CodeCategory3))
    ,(IFF(TRIM(DiagnosisCodes.CodeCategory4) = '', NULL, DiagnosisCodes.CodeCategory4))
    ,(IFF(TRIM(DiagnosisCodes.CodeCategory5) = '', NULL, DiagnosisCodes.CodeCategory5))
    ) 
AS ICD_PROCEDURE_CATEGORIES
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CODE_VERSION, PROCEDURE_CODES_CTE.PROCEDURE_CODE]) AS CLAIM_ICD_PROCEDURE_HKEY

FROM PROCEDURE_CODES_CTE
    LEFT OUTER JOIN RAWDATA.MC400_DWOAO_DIAGNOSISCODES DiagnosisCodes
        ON (DiagnosisCodes.TpaClient = PROCEDURE_CODES_CTE.TpaClient
        AND DiagnosisCodes.TpaIdOfClient = PROCEDURE_CODES_CTE.TpaIdOfClient
        AND DiagnosisCodes.TpaDivision = PROCEDURE_CODES_CTE.TpaDivision
        AND DiagnosisCodes.Code = PROCEDURE_CODES_CTE.PROCEDURE_CODE)

    --Get the most current record if there are more then one for a given code
    JOIN (SELECT TpaClient, TpaIdOfClient, TpaDivision, Code, MAX(DiagnosisEffectiveDate) AS DiagnosisEffectiveDate
            FROM RAWDATA.MC400_DWOAO_DIAGNOSISCODES
            GROUP BY TpaClient, TpaIdOfClient, TpaDivision, Code
            ) MAX_EFFECTIVE
        ON (MAX_EFFECTIVE.TpaClient = DiagnosisCodes.TpaClient
        AND MAX_EFFECTIVE.TpaIdOfClient = DiagnosisCodes.TpaIdOfClient
        AND MAX_EFFECTIVE.TpaDivision = DiagnosisCodes.TpaDivision
        AND MAX_EFFECTIVE.Code = DiagnosisCodes.Code
        AND MAX_EFFECTIVE.DiagnosisEffectiveDate = DiagnosisCodes.DiagnosisEffectiveDate)
;