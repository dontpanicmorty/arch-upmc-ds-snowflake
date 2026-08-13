
!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_PROCEDURE_CATEGORY_MC400DNT_SELECT_VW
COMMENT = 'This is a SAT View containing claim line procedure category codes'
AS
SELECT
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,ClaimsDetail.ClaimNbr AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,ARRAY_CONSTRUCT_COMPACT
    (//set any blank categories to null so they are automatically excluded from the array construct
        IFF(TRIM(ProcCodeCategory1) = '',NULL,ProcCodeCategory1)
        ,IFF(TRIM(ProcCodeCategory2) = '',NULL,ProcCodeCategory2)
        ,IFF(TRIM(ProcCodeCategory3) = '',NULL,ProcCodeCategory3)
        ,IFF(TRIM(ProcCodeCategory4) = '',NULL,ProcCodeCategory4)
        ,IFF(TRIM(ProcCodeCategory5) = '',NULL,ProcCodeCategory5)
        ,IFF(TRIM(ProcCodeCategory6) = '',NULL,ProcCodeCategory6)
        ,IFF(TRIM(ProcCodeCategory7) = '',NULL,ProcCodeCategory7)
        ,IFF(TRIM(ProcCodeCategory8) = '',NULL,ProcCodeCategory8)
        ,IFF(TRIM(ProcCodeCategory9) = '',NULL,ProcCodeCategory9)
        ,IFF(TRIM(ProcCodeCategory10) = '',NULL,ProcCodeCategory10)
        ,IFF(TRIM(ProcCodeCategory11) = '',NULL,ProcCodeCategory11)
        ,IFF(TRIM(ProcCodeCategory12) = '',NULL,ProcCodeCategory12)
        ,IFF(TRIM(ProcCodeCategory13) = '',NULL,ProcCodeCategory13)
        ,IFF(TRIM(ProcCodeCategory14) = '',NULL,ProcCodeCategory14)
        ,IFF(TRIM(ProcCodeCategory15) = '',NULL,ProcCodeCategory15)
) PROCEDURE_CATEGORY_ARRAY
,UTIL.FXN_ARRAY_HASH([PROCEDURE_CATEGORY_ARRAY]) as HASH_DIFF
FROM &{MC400}.DWDNV.ClaimsDetail
    JOIN &{MC400}.DWDNV.Claims
        ON (Claims.claimNbr = ClaimsDetail.claimNbr)

        left outer JOIN &{MC400}.DWDNV.ProcedureCodes
        JOIN (SELECT Code, Modifier, MAX(EffectiveDate) AS EffectiveDate
                FROM &{MC400}.DWDNV.ProcedureCodes
                GROUP BY Code, Modifier
            ) PROCEDURE_CODES_MAX_EFFECTIVE
            ON (PROCEDURE_CODES_MAX_EFFECTIVE.Code = ProcedureCodes.Code
            AND PROCEDURE_CODES_MAX_EFFECTIVE.Modifier = ProcedureCodes.Modifier
            AND PROCEDURE_CODES_MAX_EFFECTIVE.EffectiveDate = ProcedureCodes.EffectiveDate
            )
        ON (ProcedureCodes.Code = TRIM(ClaimsDetail.ProcedureCode)
        AND ProcedureCodes.Modifier = TRIM(ClaimsDetail.ProcedureModifier))

WHERE claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
AND PROCEDURE_CATEGORY_ARRAY <> []
;
!set variable_substitution=false;
