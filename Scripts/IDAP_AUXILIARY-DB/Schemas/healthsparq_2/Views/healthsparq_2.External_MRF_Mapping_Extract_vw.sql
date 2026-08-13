!set variable_substitution=true;
CREATE OR REPLACE VIEW HEALTHSPARQ_2.EXTERNAL_MRF_MAPPING_EXTRACT_VW AS
SELECT
     'UPMC_I' AS INSURER_CODE,
     IN_NETWORK_FILE_JSON_VW.PRICING_FILE_KEY AS PLAN_COLLECTION_KEY,
     'I' AS MRF_TYPE,
     SPLIT_PART(IN_NETWORK_FILE_JSON_VW.URL_PATH, '/', 4) || '.zip' AS EXTERNAL_MRF_FILENAME_PATTERN,
     NULL AS EXTERNAL_MRF_FILENAME_PRECEDENCE,
     NULL AS EXTERNAL_MRF_URL,
     'The ' || INITCAP(
          REPLACE(
               REGEXP_SUBSTR(
                    SPLIT_PART(IN_NETWORK_FILE_JSON_VW.URL_PATH, '/', 4),
                    '^\\d+-(.+)\\.json$',
                    1,
                    1,
                    'e',
                    1
               ),
               '-',
               ' '
          )
     ) || ' of Pricing File Key ' || REGEXP_SUBSTR(
          SPLIT_PART(IN_NETWORK_FILE_JSON_VW.URL_PATH, '/', 4),
          '^(\\d+)',
          1,
          1,
          'e'
     ) AS EXTERNAL_MRF_DESCRIPTION
FROM
     &{CMS_PRICING_2_HEALTHSPARQ}.EXTRACTDATA.IN_NETWORK_FILE_JSON_VW
/*UNION
SELECT
     'UPMC_I' AS INSURER_CODE,
     IN_NETWORK_BASE.PRICING_FILE_KEY AS PLAN_COLLECTION_KEY,
     'P' AS MRF_TYPE,
     SPLIT_PART(
          PRICING_PROVIDER_GROUP_FILE_JSON_VW.URL_PATH,
          '/',
          4
     ) || '.zip' AS EXTERNAL_MRF_FILENAME_PATTERN,
     NULL AS EXTERNAL_MRF_FILENAME_PRECEDENCE,
     NULL AS EXTERNAL_MRF_URL,
     'The ' || INITCAP(
          REPLACE(
               REGEXP_SUBSTR(
                    SPLIT_PART(
                         PRICING_PROVIDER_GROUP_FILE_JSON_VW.URL_PATH,
                         '/',
                         4
                    ),
                    '^\\d+-(.+)\\.json$',
                    1,
                    1,
                    'e',
                    1
               ),
               '-',
               ' '
          )
     ) || ' of Pricing File Key ' || REGEXP_SUBSTR(
          SPLIT_PART(
               PRICING_PROVIDER_GROUP_FILE_JSON_VW.URL_PATH,
               '/',
               4
          ),
          '^(\\d+)',
          1,
          1,
          'e'
     ) AS EXTERNAL_MRF_DESCRIPTION
FROM
     &{CMS_PRICING_2_HEALTHSPARQ}.EXTRACTDATA.IN_NETWORK_BASE
     JOIN &{CMS_PRICING_2_HEALTHSPARQ}.EXTRACTDATA.NEGOTIATED_RATES ON (
          IN_NETWORK_BASE.IN_NETWORK_BASE_KEY = NEGOTIATED_RATES.IN_NETWORK_BASE_KEY
     )
      JOIN &{CMS_PRICING_2_HEALTHSPARQ}.EXTRACTDATA.PRICING_PROVIDER_GROUP_FILE_JSON_VW ON (
          PRICING_PROVIDER_GROUP_FILE_JSON_VW.PRICING_PROVIDER_GROUP_KEY = NEGOTIATED_RATES.PRICING_PROVIDER_GROUP_KEY
     )
GROUP BY
     IN_NETWORK_BASE.PRICING_FILE_KEY--,
--     PRICING_PROVIDER_GROUP_FILE_JSON_VW.URL_PATH;
*/
!set variable_substitution=false;