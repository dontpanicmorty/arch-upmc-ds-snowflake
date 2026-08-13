create or replace view STAGEDATA.REF_CLAIM_PROCEDURE_MC400UPM_SELECT_VW
COMMENT='Source view for refdata.claim_procedure'
AS
SELECT DISTINCT
ProcedureCodes_CURRENT.TpaClient AS TPA_CLIENT_ID
,ProcedureCodes_CURRENT.TpaIdOfClient AS TPA_ID
,ProcedureCodes_CURRENT.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,ProcedureCodes_CURRENT.Code AS CODE
,TRIM(ProcedureCodes_CURRENT.ProcedureDescription) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, ProcedureCodes_CURRENT.Code]) AS CLAIM_PROCEDURE_HKEY

FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
    JOIN (SELECT TPACLIENT, TpaIdOfClient, TpaDivision, Code, ProcedureDescription
            FROM  RAWDATA.MC400_DWOAO_PROCEDURECODES PROCEDURECODES
            WHERE REGEXP_LIKE(TRIM(CODE), '^[a-zA-Z0-9]{5}$')  --only including 5-character alphanumeric codes to exclude revenue codes
            QUALIFY ROW_NUMBER() OVER(PARTITION BY TPACLIENT, TpaIdOfClient, TpaDivision, Code ORDER BY EffectiveDate DESC) = 1
            ) ProcedureCodes_CURRENT
        ON (ProcedureCodes_CURRENT.TpaClient = ClaimsDetail.TpaClient
        AND ProcedureCodes_CURRENT.TpaIdOfClient = ClaimsDetail.TpaIdOfClient
        AND ProcedureCodes_CURRENT.TpaDivision = ClaimsDetail.TpaDivision
        AND ProcedureCodes_CURRENT.CODE = ClaimsDetail.ProcedureCode)
WHERE ProcedureCodes_CURRENT.ProcedureDescription <> ''
;