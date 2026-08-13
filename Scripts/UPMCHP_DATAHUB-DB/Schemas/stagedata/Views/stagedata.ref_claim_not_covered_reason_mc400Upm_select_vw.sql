!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_NOT_COVERED_REASON_MC400UPM_SELECT_VW
AS
SELECT
NotCoveredReason.TpaClient AS TPA_CLIENT_ID
,NotCoveredReason.TPAIDOFCLIENT AS TPA_ID
,NotCoveredReason.TPADIVISION AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,CLAIM_DETAIL_NOT_COVERED_REASONS.LINE_OF_BUSINESS_CODE AS LINE_OF_BUSINESS_CODE
,'Reason' AS NOT_COVERED_REASON_TYPE
,NotCoveredReason.Code AS CODE
-- you need to string the records together one description is split across multiple records
,LISTAGG(TRIM(NotCoveredReason.Description),' ') WITHIN GROUP (ORDER BY NotCoveredReason.NotCoveredRsnCodeSeq ASC) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,NotCoveredReason.Hipaa277ReasonCode AS HIPAA_277_CODE
,NotCoveredReason.Hipaa835ReasonCode AS HIPAA_835_CODE
,TO_BOOLEAN(NULL) AS MEMBER_PAY_FLAG
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, LINE_OF_BUSINESS_CODE, NOT_COVERED_REASON_TYPE, CODE]) AS CLAIM_NOT_COVERED_REASON_HKEY
FROM 
    (
        SELECT DISTINCT
        ClaimsDetail.TpaClient
        ,ClaimsDetail.TpaIdOfClient
        ,ClaimsDetail.TpaDivision
        ,ClaimsDetail.NotCoveredReason AS NOT_COVERED_REASON_CODE
        ,LOB_PLAN_TYPE.LINE_OF_BUSINESS_CODE
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL ClaimsDetail
            JOIN RAWDATA.MC400_DWOAO_CLAIMS Claims
                ON (Claims.TpaClient = ClaimsDetail.TpaClient
                AND Claims.TpaIdOfClient = ClaimsDetail.TpaIdOfClient
                AND Claims.TpaDivision = ClaimsDetail.TpaDivision
                AND Claims.ClaimNbr = ClaimsDetail.ClaimNbr)
            LEFT OUTER JOIN &{IDAP_LAKE}.NETWORK.LOB_PLAN_TYPE
                ON (LOB_PLAN_TYPE.TPA_CLIENT_ID = Claims.TpaClient
                AND LOB_PLAN_TYPE.TPA_ID = Claims.TpaIdOfClient
                AND LOB_PLAN_TYPE.TPA_DIV_ID = Claims.TpaDivision
                AND LOB_PLAN_TYPE.PLAN_TYPE = Claims.PlanType)
        WHERE IFNULL(ClaimsDetail.NotCoveredReason,'') <> ''
    ) CLAIM_DETAIL_NOT_COVERED_REASONS
    JOIN RAWDATA.MC400_DWOAO_NOTCOVEREDREASON NotCoveredReason
        ON (NotCoveredReason.TpaClient = CLAIM_DETAIL_NOT_COVERED_REASONS.TpaClient
        AND NotCoveredReason.TpaIdOfClient = CLAIM_DETAIL_NOT_COVERED_REASONS.TpaIdOfClient
        AND NotCoveredReason.TpaDivision = CLAIM_DETAIL_NOT_COVERED_REASONS.TpaDivision
        AND NotCoveredReason.Code = CLAIM_DETAIL_NOT_COVERED_REASONS.NOT_COVERED_REASON_CODE
        AND DELETEDFLAG = '1900-01-01 00:00:00.000')
GROUP BY TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, LINE_OF_BUSINESS_CODE, NOT_COVERED_REASON_TYPE, CODE, HIPAA_277_CODE, HIPAA_835_CODE
;

!set variable_substitution=false;