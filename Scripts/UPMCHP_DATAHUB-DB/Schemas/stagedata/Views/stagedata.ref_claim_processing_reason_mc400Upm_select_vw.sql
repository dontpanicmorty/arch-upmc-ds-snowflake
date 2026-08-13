CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_PROCESSING_REASON_MC400UPM_SELECT_VW
COMMENT = 'Source view for MC400Upm Claim Processing Reason(s) data'
AS 
SELECT
claimsDetail.TpaClient AS TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS TPA_ID
,claimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,'CoPay' AS CLAIM_PROCESSING_REASON_TYPE
,CoPayReason.Code AS CODE
-- you need to string the records together one description is split across multiple records
,LISTAGG(TRIM(CoPayReason.Description),' ') WITHIN GROUP (ORDER BY CoPayReason.CoPayRsnCodeSeq ASC) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,Hipaa277ReasonCode AS HIPAA_277_CODE
,Hipaa835ReasonCode AS HIPAA_835_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE]) AS CLAIM_PROCESSING_REASON_HKEY
FROM RAWDATA.MC400_DWOAO_COPAYREASON CoPayReason
    JOIN ( --only take codes that are on a claim
        SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, CoPayReason
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL
        ) claimsDetail
    ON (claimsDetail.CoPayReason = CoPayReason.Code)
GROUP BY TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE, HIPAA_277_CODE, HIPAA_835_CODE

UNION ALL

SELECT
claimsDetail.TpaClient AS TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS TPA_ID
,claimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,'Deductible' AS CLAIM_PROCESSING_REASON_TYPE
,DeductibleReasonMaster.DeductibleReason AS CODE
-- you need to string the records together one description is split across multiple records
,LISTAGG(TRIM(DeductibleReasonMaster.DeductibleReasonDescrption),' ') WITHIN GROUP (ORDER BY DeductibleReasonMaster.DeductibleRsnCodeSeq ASC) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,DeductibleReasonMaster.Hipaa277ReasonCode AS HIPAA_277_CODE
,DeductibleReasonMaster.Hipaa835ReasonCode AS HIPAA_835_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE]) AS CLAIM_PROCESSING_REASON_HKEY
FROM RAWDATA.MC400_DWOAO_DEDUCTIBLEREASONMASTER DeductibleReasonMaster
    JOIN ( --only take codes that are on a claim
        SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, DeductibleReason
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL
        ) claimsDetail
    ON (claimsDetail.DeductibleReason = DeductibleReasonMaster.DeductibleReason)
GROUP BY TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE, HIPAA_277_CODE, HIPAA_835_CODE

UNION ALL

SELECT 
claimsDetail.TpaClient AS TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS TPA_ID
,claimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,'CoInsurance' AS CLAIM_PROCESSING_REASON_TYPE
,CoPayReason.Code AS CODE
-- you need to string the records together one description is split across multiple records
,LISTAGG(TRIM(CoPayReason.Description),' ') WITHIN GROUP (ORDER BY CoPayReason.CoPayRsnCodeSeq ASC) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,CoPayReason.Hipaa277ReasonCode AS HIPAA_277_CODE
,CoPayReason.Hipaa835ReasonCode AS HIPAA_835_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE]) AS CLAIM_PROCESSING_REASON_HKEY
FROM RAWDATA.MC400_DWOAO_COPAYREASON CoPayReason
    JOIN ( --only take codes that are on a claim
        SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, CoInsuranceReason
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL
        ) claimsDetail
    ON (claimsDetail.CoInsuranceReason = CoPayReason.Code)
GROUP BY TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE, HIPAA_277_CODE, HIPAA_835_CODE

UNION ALL

SELECT
claimsDetail.TpaClient AS TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS TPA_ID
,claimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,'Service' AS CLAIM_PROCESSING_REASON_TYPE
,ServiceReason.Code AS CODE
,TRIM(ServiceReason.Description) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,NULL AS HIPAA_277_CODE
,NULL AS HIPAA_835_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE]) AS CLAIM_PROCESSING_REASON_HKEY
FROM RAWDATA.MC400_DWOAO_SERVICEREASON ServiceReason
    JOIN ( --only take codes that are on a claim
        SELECT DISTINCT TpaClient, TpaIdOfClient, TpaDivision, ServiceReason
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL
        ) claimsDetail
    ON (claimsDetail.TpaClient = ServiceReason.TpaClient
    AND claimsDetail.TpaIdOfClient = ServiceReason.TpaIdOfClient
    AND claimsDetail.TpaDivision = ServiceReason.TpaDivision
    AND claimsDetail.ServiceReason = ServiceReason.Code)

UNION ALL

SELECT
claimsDetail.TpaClient AS TPA_CLIENT_ID
,claimsDetail.TpaIdOfClient AS TPA_ID
,claimsDetail.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,'Adjustment' AS CLAIM_PROCESSING_REASON_TYPE
,AdjustmentReason.Code AS CODE
-- you need to string the records together one description is split across multiple records
,LISTAGG(TRIM(AdjustmentReason.Description),' ') WITHIN GROUP (ORDER BY AdjustmentReason.AdjustmentRsnCodeSeq ASC) AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,Hipaa277ReasonCode AS HIPAA_277_CODE
,Hipaa835ReasonCode AS HIPAA_835_CODE
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE]) AS CLAIM_PROCESSING_REASON_HKEY
FROM RAWDATA.MC400_DWOAO_ADJUSTMENTREASON AdjustmentReason
    JOIN ( --only take codes that are on a claim
        SELECT TpaClient, TpaIdOfClient, TpaDivision, AdjustmentReason1 AS AdjustmentReason
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL
        UNION
        SELECT TpaClient, TpaIdOfClient, TpaDivision, AdjustmentReason2 AS AdjustmentReason
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL
        ) claimsDetail
    ON (claimsDetail.TpaClient = AdjustmentReason.TpaClient
    AND claimsDetail.TpaIdOfClient = AdjustmentReason.TpaIdOfClient
    AND claimsDetail.TpaDivision = AdjustmentReason.TpaDivision
    AND claimsDetail.AdjustmentReason = AdjustmentReason.Code)
GROUP BY TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_PROCESSING_REASON_TYPE, CODE, HIPAA_277_CODE, HIPAA_835_CODE
;

