CREATE OR REPLACE VIEW NETWORK.SIMPLIFY_CASCADING_COST_SHARE_VW
COMMENT = 'Parses out Cascading_Cost_Share column from JSON leaving nested arrays still as arrays so its one row per documentID/SimplifyPlanPackageKey'
AS 

(  

SELECT  C.Document_ID,
    C.SIMPLIFY_PLAN_PACKAGE_KEY,
    COINSURANCE_AMOUNT,
    COPAY_FREQUENCY,
    COPAY_VALUE,
    COST_SHARE_GROUP,
    COST_SHARE_TYPE,
    NETWORK_NAME,
    NETWORK_TIER

FROM
     (SELECT DISTINCT V.Document_ID
        ,V.SIMPLIFY_PLAN_PACKAGE_KEY
        ,value:CoinsuranceAmount::String AS COINSURANCE_AMOUNT
        ,value:CopayFrequency::string AS COPAY_FREQUENCY
        ,value:CopayValue::string AS COPAY_VALUE
        ,value:CostShareGroup::string AS COST_SHARE_GROUP
        ,value:CostShareType::string AS COST_SHARE_TYPE
        ,value:NetworkName::string AS NETWORK_NAME
        ,value:NetworkTier::string AS NETWORK_TIER
      FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V,lateral flatten( input => CASCADINGCOSTSHARE:CostShareGroup:CostShareGroupList) ) C

  INNER JOIN

  IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW CR ON 
    C.SIMPLIFY_PLAN_PACKAGE_KEY = CR.SIMPLIFY_PLAN_PACKAGE_KEY
)
;



