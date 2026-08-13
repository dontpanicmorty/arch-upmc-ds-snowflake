CREATE OR REPLACE VIEW EXTRACTDATA.TABLE_OF_CONTENTS_FILE_JSON_VW AS
-- Mandated syntax for ToC filenames is `<YYYY-MM-DD>_<payer or issuer name>_index.json`
-- with payer/issuer name spaces replaced with hyphens. These two default props
-- use the current date.
SELECT
  EXTRACTDATA.FXN_MAKE_URL_PATH (
    'table-of-contents',
    'UPMC-Health-Plan_index'
  ) AS URL_PATH,
  EXTRACTDATA.FXN_PREPEND_STAGING_CONTAINER_URL (URL_PATH) AS URL,
  REPORTING_ENTITY.REPORTING_ENTITY_KEY,
  OBJECT_CONSTRUCT(
    'reporting_entity_name',
    REPORTING_ENTITY_NAME,
    'reporting_entity_type',
    REPORTING_ENTITY_TYPE,
    'reporting_structure',
    ARRAY_AGG(
      REPORTING_STRUCTURE
    ),
    'last_updated_on',
    CURRENT_TIMESTAMP()
  ) AS JSON_DATA
FROM
  EXTRACTDATA.REPORTING_ENTITY
  LEFT JOIN (
    -- Top-level for structure is an array of reporting plans, array of in-network, single allowed-amount
    SELECT
      REPORTING_ENTITY_KEY,
      OBJECT_CONSTRUCT(
        'reporting_plans',
        ARRAY_AGG(
          PRICING_PLAN_JSON
        ),
        'allowed_amount_file',
        ALLOWED_AMOUNTS.FILE_JSON,
        'in_network_files',
        IN_NETWORK_RATES.FILE_JSON -- pre-array_agg'd
      ) AS REPORTING_STRUCTURE
    FROM
      EXTRACTDATA.PRICING_PLAN_JSON_VW
      LEFT JOIN (
        -- Can only have a single allowed-amounts file, so no array_agg needed
        SELECT
          PRICING_PLAN_FILE_REL.PRICING_PLAN_KEY,
          PRICING_FILE_JSON AS FILE_JSON
        FROM
          EXTRACTDATA.PRICING_FILE_JSON_VW
          LEFT JOIN EXTRACTDATA.PRICING_PLAN_FILE_REL ON PRICING_PLAN_FILE_REL.PRICING_FILE_KEY = PRICING_FILE_JSON_VW.PRICING_FILE_KEY
        WHERE
          FILE_TYPE_NAME = 'allowed-amounts'
      ) ALLOWED_AMOUNTS ON ALLOWED_AMOUNTS.PRICING_PLAN_KEY = PRICING_PLAN_JSON_VW.PRICING_PLAN_KEY
      LEFT JOIN (
        -- Array_agg on in-network files
        SELECT
          PRICING_PLAN_FILE_REL.PRICING_PLAN_KEY,
          ARRAY_AGG(
            PRICING_FILE_JSON
          ) AS FILE_JSON
        FROM
          EXTRACTDATA.PRICING_FILE_JSON_VW
          LEFT JOIN EXTRACTDATA.PRICING_PLAN_FILE_REL ON PRICING_PLAN_FILE_REL.PRICING_FILE_KEY = PRICING_FILE_JSON_VW.PRICING_FILE_KEY
          -- TODO: ensure Cigna file's getting linked once this is set
        WHERE
          FILE_TYPE_NAME = 'in-network-rates'
        GROUP BY
          PRICING_PLAN_FILE_REL.PRICING_PLAN_KEY
      ) IN_NETWORK_RATES ON IN_NETWORK_RATES.PRICING_PLAN_KEY = PRICING_PLAN_JSON_VW.PRICING_PLAN_KEY
    GROUP BY
      REPORTING_ENTITY_KEY,
      ALLOWED_AMOUNTS.FILE_JSON,
      IN_NETWORK_RATES.FILE_JSON
  ) REPORTING_STRUCTURES ON REPORTING_ENTITY.REPORTING_ENTITY_KEY = REPORTING_STRUCTURES.REPORTING_ENTITY_KEY
GROUP BY
  REPORTING_ENTITY_NAME,
  REPORTING_ENTITY_TYPE,
  REPORTING_ENTITY.REPORTING_ENTITY_KEY;