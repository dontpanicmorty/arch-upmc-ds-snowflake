CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_BILLING_TYPE_MC400UPM_SELECT_VW
COMMENT = 'This is a REF View containing Claim Bill Type data'
AS
SELECT DISTINCT
claims.tpaClient AS TPA_CLIENT_ID
,claims.tpaIdOfClient AS TPA_ID
,claims.tpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ub92FieldValidation.GenericCodeValue as CODE
,IFF(IFNULL(ub92FieldValidation.GenericCodeDescription,'') = '', NULL, ub92FieldValidation.GenericCodeDescription) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CODE]) AS CLAIM_BILLING_TYPE_HKEY
FROM RAWDATA.MC400_DWOAO_UB92FIELDVALIDATION ub92FieldValidation
    JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
        ON (claims.BillType = ub92FieldValidation.GenericCodeValue)
WHERE UPPER(GenericCodeFieldName) = 'BILLTYPE'
AND claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
;