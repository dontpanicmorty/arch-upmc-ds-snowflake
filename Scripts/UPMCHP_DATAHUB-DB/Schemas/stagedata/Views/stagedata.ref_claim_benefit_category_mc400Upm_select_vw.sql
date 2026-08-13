CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_BENEFIT_CATEGORY_MC400UPM_SELECT_VW
COMMENT = 'This is a REF View containing Claim Benefit Category data'
AS
SELECT DISTINCT
BenefitCategory.TpaClient AS TPA_CLIENT_ID
,BenefitCategory.TpaIdOfClient AS TPA_ID
,BenefitCategory.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,BenefitCategory.PlanType AS PLAN_TYPE_CODE
,BenefitCategory.Category as CODE
,REPLACE(TRIM(BenefitCategory.Description),'  ',' ') AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, PLAN_TYPE_CODE, CODE]) AS CLAIM_BENEFIT_CATEGORY_HKEY
FROM RAWDATA.MC400_DWOAO_BENEFITCATEGORY BenefitCategory
    JOIN (SELECT TpaClient, TpaIdOfClient, TpaDivision, FileType, PlanType, Category, MAX(EffDate) AS EffDate 
            FROM RAWDATA.MC400_DWOAO_BENEFITCATEGORY
            GROUP BY TpaClient, TpaIdOfClient, TpaDivision, FileType, PlanType, Category) MAX_EFFECTIVE
        ON (MAX_EFFECTIVE.TpaClient = BenefitCategory.TpaClient
        AND MAX_EFFECTIVE.TpaIdOfClient = BenefitCategory.TpaIdOfClient
        AND MAX_EFFECTIVE.TpaDivision = BenefitCategory.TpaDivision
        AND MAX_EFFECTIVE.FileType = BenefitCategory.FileType
        AND MAX_EFFECTIVE.PlanType = BenefitCategory.PlanType
        AND MAX_EFFECTIVE.Category = BenefitCategory.Category
        AND MAX_EFFECTIVE.EffDate = BenefitCategory.EffDate)

WHERE BenefitCategory.DeletedFlag = '1900-01-01 00:00:00.000'
AND BenefitCategory.FileType = 'I' --(FileType is ClaimType)  This might need revisted claimType E
AND (BenefitCategory.tpaClient, BenefitCategory.tpaIdOfClient, BenefitCategory.tpaDivision, BenefitCategory.Category) IN 
    (
        SELECT DISTINCT claimsDetail.tpaClient, claimsDetail.tpaIdOfClient, claimsDetail.tpaDivision, claimsDetail.benefitCategory
        FROM RAWDATA.MC400_DWOAO_CLAIMSDETAIL claimsDetail
            JOIN RAWDATA.MC400_DWOAO_CLAIMS claims
                ON (claims.tpaClient = claimsDetail.tpaClient
                AND claims.tpaIdOfClient = claimsDetail.tpaIdOfClient
                AND claims.tpaDivision = claimsDetail.tpaDivision
                AND claims.claimNbr = claimsDetail.claimNbr)
        WHERE claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
    )

QUALIFY DENSE_RANK() OVER --take the highest priority record out of the dupicates (aka different descriptions, bad data in mc400)
    (PARTITION BY BenefitCategory.tpaClient, BenefitCategory.tpaIdOfClient, BenefitCategory.tpaDivision, BenefitCategory.FileLevel, BenefitCategory.FileType, BenefitCategory.PlanType, BenefitCategory.Category ORDER BY priority) = 1

;