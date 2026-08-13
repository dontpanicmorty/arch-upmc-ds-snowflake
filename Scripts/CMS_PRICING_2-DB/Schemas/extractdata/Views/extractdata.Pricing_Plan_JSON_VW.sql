CREATE OR REPLACE VIEW EXTRACTDATA.PRICING_PLAN_JSON_VW AS
-- Makes easier-to-select JSON from pricing_plan
SELECT
  REPORTING_ENTITY_KEY,
  PRICING_PLAN_KEY,
  OBJECT_CONSTRUCT(
    'plan_name', PLAN_NAME,
    'plan_id_type', PLAN_ID_TYPE,
    'plan_id', PLAN_ID,
    'plan_market_type', PLAN_MARKET_TYPE_NAME,
    'issuer_name', ISSUER_NAME,
    'plan_sponsor_name', PLAN_SPONSOR_NAME
  ) AS PRICING_PLAN_JSON
FROM
  EXTRACTDATA.PRICING_PLAN;