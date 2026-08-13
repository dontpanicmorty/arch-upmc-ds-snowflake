CREATE OR REPLACE VIEW NETWORK.SIMPLIFY_BENEFIT_REVIEW_VW
COMMENT = 'Parses out Benefit_Review column from JSON leaving nested arrays still as arrays so its one row per documentID/SimplifyPlanPackageKey'
AS 

(  

SELECT  C.Document_ID
    ,C.SIMPLIFY_PLAN_PACKAGE_KEY
    ,BENEFIT_CATEGORY1
    ,BENEFIT_CATEGORY2
    ,BENEFIT_SERVICE_CODE
    ,COINSURANCE
    ,COPAY
    ,COPAY_FREQUENCY
    ,COPAY_SUPPLEMENT
    ,COST_SHARE_GROUP
    ,COST_SHARE_TYPE
    ,DEDUCTIBLE_TYPE
    ,FAM_DEDUCTIBLE
    ,FAMILY_OOPM
    ,IND_DEDUCTIBLE
    ,IND_OOPM
    ,NETWORK_NAME
    ,NETWORK_TIER

FROM
     (SELECT DISTINCT V.Document_ID
        ,V.SIMPLIFY_PLAN_PACKAGE_KEY
        ,value:BenefitCategory1::String AS BENEFIT_CATEGORY1
        ,value:BenefitCategory2::String AS BENEFIT_CATEGORY2
        ,value:BenefitServiceCode::String AS BENEFIT_SERVICE_CODE
        ,value:Coinsurance::String AS COINSURANCE
        ,value:Copay::String AS COPAY
        ,value:CopayFrequency::string AS COPAY_FREQUENCY
        ,value:CopaySupplement::string AS COPAY_SUPPLEMENT
        ,value:CostShareGroup::string AS COST_SHARE_GROUP
        ,value:CostShareType::string AS COST_SHARE_TYPE
        ,value:DeductibleType::String AS DEDUCTIBLE_TYPE
        ,value:FamDeductible::String AS FAM_DEDUCTIBLE
        ,value:FamilyOOPM::String AS FAMILY_OOPM
        ,value:IndDeductible::String AS IND_DEDUCTIBLE
        ,value:IndOOPM::String AS IND_OOPM
        ,value:NetworkName::string AS NETWORK_NAME
        ,value:NetworkTier::string AS NETWORK_TIER
      FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V,lateral flatten( input => BENEFITREVIEW:BenefitReviewGrid) ) C

  INNER JOIN

  IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW CR ON 
    C.SIMPLIFY_PLAN_PACKAGE_KEY = CR.SIMPLIFY_PLAN_PACKAGE_KEY
)
;



