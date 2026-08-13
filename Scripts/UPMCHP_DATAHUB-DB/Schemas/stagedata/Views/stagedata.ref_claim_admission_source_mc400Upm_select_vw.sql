CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_ADMISSION_SOURCE_MC400UPM_SELECT_VW
COMMENT = 'This is a REF View containing admission source codes and descriptions'
AS
SELECT DISTINCT
claims.tpaClient AS TPA_CLIENT_ID
,claims.tpaIdOfClient AS TPA_ID
,claims.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,Claims.AdmissionType AS ADMISSION_TYPE_CODE
,ub92FieldValidation.GenericCodeValue AS CODE
,IFF(IFNULL(ub92FieldValidation.GenericCodeDescription,'') = '', NULL, ub92FieldValidation.GenericCodeDescription) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, ADMISSION_TYPE_CODE, CODE]) AS CLAIM_ADMISSION_SOURCE_HKEY
FROM RAWDATA.MC400_DWOAO_UB92FIELDVALIDATION ub92FieldValidation
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.AdmissionSource = ub92FieldValidation.GenericCodeValue)
WHERE UPPER(GenericCodeFieldName) = 'ADMSRC1'
AND claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
AND claims.AdmissionType <> '4' -- some crazy mc400 logic where Newborns have a different admission source list

UNION ALL

SELECT DISTINCT
claims.tpaClient AS TPA_CLIENT_ID
,claims.tpaIdOfClient AS TPA_ID
,claims.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,Claims.AdmissionType AS ADMISSION_TYPE_CODE
,ub92FieldValidation.GenericCodeValue AS CODE
,IFF(IFNULL(ub92FieldValidation.GenericCodeDescription,'') = '', NULL, ub92FieldValidation.GenericCodeDescription) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, ADMISSION_TYPE_CODE, CODE]) AS CLAIM_ADMISSION_SOURCE_HKEY
FROM RAWDATA.MC400_DWOAO_UB92FIELDVALIDATION ub92FieldValidation
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.AdmissionSource = ub92FieldValidation.GenericCodeValue)
WHERE UPPER(GenericCodeFieldName) = 'ADMSRC2'
AND claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
AND claims.AdmissionType = '4' -- some crazy mc400 logic where Newborns have a different admission source list
;