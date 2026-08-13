!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.PRICING_FILE_SELECT_VW
AS
-- Big note: for now, we're using FILE_DESC as the unique component because
-- segment and prov_set are the two unique keys in the source data
SELECT 
    SEGMENT, -- for internal joins
    PROV_SET, -- for internal joins
    3 AS REPORTING_ENTITY_KEY, -- from StaticData, UPMC value
    'in-network-rates' AS FILE_TYPE_NAME,
    STAGEDATA.FXN_MAKE_IN_NETWORK_FILE_DESC(SEGMENT, PROV_SET) AS FILE_DESC,
    '' AS FILE_LOCATION_URL,
    CURRENT_DATE() AS LAST_UPDATED_ON_DATE
FROM (
    -- Used to be distinct, but now there's a link to all plan info
    SELECT DISTINCT SEGMENT, PROV_SET
    FROM &{IDAP_LAKE}.PRICING.PLAN_INFO
) PLAN_INFO

UNION

-- SEGMENT and PROV_SET are only included to make the UNION work, provider sets 
-- aren't used for allowed-amounts and this doesn't add more rows since PLAN_INFO
-- is at plan_code-granularity anyway
SELECT DISTINCT
    SEGMENT,
    PROV_SET,
    3 AS REPORTING_ENTITY_KEY, -- from StaticData, UPMC value
    'allowed-amounts' AS FILE_TYPE_NAME,
    STAGEDATA.FXN_MAKE_ALLOWED_AMOUNTS_FILE_DESC(PLAN_CODE, THRESHOLD_GROUPING, PLAN_ID) AS FILE_DESC,
    '' AS FILE_LOCATION_URL,
    CURRENT_DATE() AS LAST_UPDATED_ON_DATE
FROM (
  SELECT DISTINCT SEGMENT, PROV_SET, PLAN_CODE, PLAN_NAME, PLAN_ID_TYPE, PLAN_ID, MARKET_TYPE, THRESHOLD_GROUPING
    FROM &{IDAP_LAKE}.PRICING.PLAN_INFO
) PLAN_CODES

/*
Eventually TODO once the PLAN_INFO file contains Cigna = Y values - we'll need
to include the Cigna file as in-network if that column is set to Y.
*/
;

!set variable_substitution=false;