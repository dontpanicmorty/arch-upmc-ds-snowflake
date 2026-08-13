!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_PROCEDURE_MC400DNT_SELECT_VW
COMMENT = 'Source view for refdata.claim_procedure'
AS
SELECT DISTINCT
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,ClaimsDetail.ProcedureCode AS CODE
,ProcedureCodes_CURRENT.ProcedureDescription AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, ClaimsDetail.ProcedureCode]) AS CLAIM_PROCEDURE_HKEY

FROM &{MC400}.DWDNV.ClaimsDetail
    JOIN (SELECT Code, ProcedureDescription
                    FROM  &{MC400}.DWDNV.ProcedureCodes
                    WHERE REGEXP_LIKE(TRIM(CODE), '^[a-zA-Z0-9]{5}$') --only including 5-character alphanumeric codes to exclude revenue codes
                    QUALIFY ROW_NUMBER() OVER(PARTITION BY CODE ORDER BY EffectiveDate DESC) = 1
                    ) ProcedureCodes_CURRENT
        ON (ProcedureCodes_CURRENT.CODE = ClaimsDetail.ProcedureCode)
WHERE ProcedureCodes_CURRENT.ProcedureDescription <> ''
;

!set variable_substitution=false;
