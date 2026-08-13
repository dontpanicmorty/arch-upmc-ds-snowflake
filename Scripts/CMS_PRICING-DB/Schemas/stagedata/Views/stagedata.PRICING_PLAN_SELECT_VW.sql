!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.PRICING_PLAN_SELECT_VW
AS
-- Actually the simplest thing here
SELECT DISTINCT 
  3 AS REPORTING_ENTITY_KEY, -- from StaticData, UPMC value
  PLAN_NAME, 
  PLAN_ID_TYPE, 
  PLAN_ID, 
  MARKET_TYPE AS PLAN_MARKET_TYPE_NAME
FROM &{IDAP_LAKE}.PRICING.PLAN_INFO
;

!set variable_substitution=false;