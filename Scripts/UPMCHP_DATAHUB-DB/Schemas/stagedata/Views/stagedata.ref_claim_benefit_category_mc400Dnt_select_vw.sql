!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.REF_CLAIM_BENEFIT_CATEGORY_MC400DNT_SELECT_VW
COMMENT = 'This is a REF View containing Claim Benefit Category data'
AS
SELECT DISTINCT
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,BenefitCategory.PlanType AS PLAN_TYPE_CODE
,BenefitCategory.Category as CODE
,REPLACE(TRIM(BenefitCategory.Description),'  ',' ') AS CODE_DESC
,NULL AS CODE_DESC_LONG
,NULL AS CODE_SPANISH_DESC
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, PLAN_TYPE_CODE, CODE]) AS CLAIM_BENEFIT_CATEGORY_HKEY
FROM &{MC400}.DWDNV.BenefitCategory
    JOIN (SELECT PlanType, Category, MAX(EffDate) AS EffDate FROM &{MC400}.DWDNV.BenefitCategory GROUP BY PlanType, Category) MAX_EFFECTIVE
        ON (MAX_EFFECTIVE.PlanType = BenefitCategory.PlanType
        AND MAX_EFFECTIVE.Category = BenefitCategory.Category
        AND MAX_EFFECTIVE.EffDate = BenefitCategory.EffDate)
        
WHERE BenefitCategory.DeletedFlag = '1900-01-01 00:00:00.000'
AND BenefitCategory.FileType = 'G' --(FileType is ClaimType) "G" is technically "E", it was never converted in legacy mc400 stuff
AND BenefitCategory.Category IN
    (SELECT DISTINCT BenefitCategory FROM &{MC400}.DWDNV.ClaimsDetail WHERE ClaimNbr IN 
        (SELECT ClaimNbr FROM &{MC400}.DWDNV.Claims WHERE MemberNbr <> '99999999901') --Exclude Generic Default Member Claims
    ) 
ORDER BY BenefitCategory.PlanType, BenefitCategory.Category
;

!set variable_substitution=false;