CREATE OR REPLACE VIEW NETWORK.SIMPLIFY_STANDARD_SERVICES_VW 
COMMENT = 'Parses out Standard_Srvices column from JSON leaving nested arrays still as arrays so its one row per documentID/SimplifyPlanPackageKey'
AS 

(  

SELECT  C.Document_ID,
C.SIMPLIFY_PLAN_PACKAGE_KEY,
BenefitCategory1 AS BENEFIT_CATEGORY1,
BenefitCategory2 AS BENEFIT_CATEGORY2,
BenefitServiceCode AS BENEFIT_SERVICE_CODE,
CostShareGroup AS COST_SHARE_GROUP


FROM
     (SELECT DISTINCT V.Document_ID
     ,V.SIMPLIFY_PLAN_PACKAGE_KEY
     ,value:BenefitCategory1::String AS BenefitCategory1
     ,value:BenefitCategory2::string AS BenefitCategory2
     ,value:BenefitServiceCode::string AS BenefitServiceCode
     ,value:CostShareGroup::string AS CostShareGroup
     FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V ,lateral flatten( input => STANDARDSERVICES:StandardServiceList) ) C


INNER JOIN

  IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW CR ON 
    C.SIMPLIFY_PLAN_PACKAGE_KEY = CR.SIMPLIFY_PLAN_PACKAGE_KEY
)
;