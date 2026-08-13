create or replace view NETWORK.SIMPLIFY_NETWORK_FLATTEN_VW(
    SIMPLIFY_PLAN_PACKAGE_KEY,
    DOCUMENT_ID,
    NETWORK_ID,
    BEN_YR,
    MARKET,
    IN_DISPLAY,
    NET_SERV_DESCR,
    OON_DISPLAY,
    L2_DISPLAY,
    IN_TIER_NAME,
    OON_TIER_NAME,
    L2_TIER_NAME,
    NETWORKSORT,
    NETWORK_DISPLAY_NAME,
    NETWORK_CONSUMER_DESC,
    COVERAGE,
    PLAN_OPTIONS,
    WEB_IMAGE_FILENAME_NET_SIZE,
    WEB_IMAGE_FILENAME_NET_MAP,
    WEB_IMAGE_FILENAME_NET_PDF,
    K_VALUE_SUBPROD_KEY,
    DENTAL_NETWORK_K_VALUE,
    DENTAL_NETWORK_URL,
    VISION_NETWORK_K_VALUE,
    VISION_NETWORK_URL,
    CMS_PROV_SEARCH_URL,
    UPDATE_DATE,
    LOAD_DATE,
    UPDATE_USER
) COMMENT='Parses out network column information from JSON to provide one row per DocumentID/SimplifyPlanPackageKey'
as

WITH net AS (
    SELECT
      SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY AS SIMPLIFY_PLAN_PACKAGE_KEY,
      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID::NUMBER AS DOCUMENT_ID,
      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::STRING AS Network_ID, -- NETWORK_ID

      /* BEN_YR derived from effective-date fields by product type, coerced to year as VARCHAR */
      CASE
        WHEN UPPER(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE' THEN
          TO_VARCHAR(EXTRACT(YEAR FROM COALESCE(
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING, 'YYYY-MM-DD'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'YYYY-MM-DD')
          )))
        WHEN UPPER(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE' THEN
          TO_VARCHAR(EXTRACT(YEAR FROM COALESCE(
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.PlanEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.PlanEffectiveDate::STRING, 'YYYY-MM-DD'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::STRING, 'YYYY-MM-DD'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'YYYY-MM-DD')
          )))
        WHEN UPPER(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE' THEN
          TO_VARCHAR(EXTRACT(YEAR FROM COALESCE(
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.PlanEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.PlanEffectiveDate::STRING, 'YYYY-MM-DD'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::STRING, 'YYYY-MM-DD'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'YYYY-MM-DD')
          )))
        ELSE
          TO_VARCHAR(EXTRACT(YEAR FROM COALESCE(
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'MM/DD/YYYY'),
            TRY_TO_DATE(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING, 'YYYY-MM-DD')
          )))
      END AS Ben_Yr,

      /* MARKET */
      NULLIF(
        TRIM(
          CASE
            /* MEDICAL */
            WHEN UPPER(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE' THEN
              CASE
                WHEN REGEXP_LIKE(
                       UPPER(
                         COALESCE(
                           NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING, ''),
                           NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                         )
                       ),
                       'INDIVIDUAL'
                     ) THEN 'IND'
                WHEN UPPER(
                       COALESCE(
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING, ''),
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                       )
                     ) = 'SMALL GROUP' THEN 'SG'
                WHEN UPPER(
                       COALESCE(
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING, ''),
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                       )
                     ) = 'LARGE GROUP' THEN 'LG'
                ELSE NULL
              END

            /* DENTAL */
            WHEN UPPER(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE' THEN
              CASE
                WHEN REGEXP_LIKE(
                       UPPER(
                         COALESCE(
                           NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.MarketSegment::STRING, ''),
                           NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                         )
                       ),
                       'INDIVIDUAL'
                     ) THEN 'IND'
                WHEN UPPER(
                       COALESCE(
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.MarketSegment::STRING, ''),
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                       )
                     ) = 'SMALL GROUP' THEN 'SG'
                WHEN UPPER(
                       COALESCE(
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.MarketSegment::STRING, ''),
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                       )
                     ) = 'LARGE GROUP' THEN 'LG'
                ELSE NULL
              END

            /* VISION */
            WHEN UPPER(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE' THEN
              CASE
                WHEN REGEXP_LIKE(
                       UPPER(
                         COALESCE(
                           NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.MarketSegment::STRING, ''),
                           NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                         )
                       ),
                       'INDIVIDUAL'
                     ) THEN 'IND'
                WHEN UPPER(
                       COALESCE(
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.MarketSegment::STRING, ''),
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                       )
                     ) = 'SMALL GROUP' THEN 'SG'
                WHEN UPPER(
                       COALESCE(
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.MarketSegment::STRING, ''),
                         NULLIF(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING, '')
                       )
                     ) = 'LARGE GROUP' THEN 'LG'
                ELSE NULL
              END

            ELSE NULL
          END
        ),
        ''
      ) AS MARKET,

      'Yes' AS IN_Display, -- IN_DISPLAY
      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetworkServiceDescription::STRING AS Net_Serv_Descr, -- NET_SERV_DESCR

      CASE
        WHEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING = 'UPMC Premium Network'
          THEN 'Yes' ELSE 'No'
      END AS OON_Display, -- OON_DISPLAY

      'No' AS L2_Display,    -- L2_DISPLAY
      ''  AS IN_Tier_name,   -- IN_TIER_NAME
      ''  AS OON_Tier_name,  -- OON_TIER_NAME
      ''  AS L2_Tier_name,   -- L2_TIER_NAME

      CASE SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING
        WHEN 'UPMC Partner Network'  THEN '1'
        WHEN 'UPMC Select Network'   THEN '2'
        WHEN 'UPMC Premium Network'  THEN '3'
        WHEN 'UPMC Standard Network' THEN '4'
        ELSE 'Missing'
      END AS NetworkSort, -- NETWORK SORT

      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING AS Network_Display_Name, -- NETWORK_DISPLAY_NAME

      CASE SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING
        WHEN 'UPMC Partner Network'  THEN 'The UPMC Partner Network is our most affordable option. You can choose from many high-quality'
        WHEN 'UPMC Select Network'   THEN 'The UPMC Select Network is an affordable option with many high-quality'
        WHEN 'UPMC Premium Network'  THEN 'The UPMC Premium Network is our highest-priced and broadest network. It is available to Pennsylvania residents who want to seek both in-network and out-of-network care across the state. In-network providers include all Tower Health and UPMC doctors and hospitals'
        WHEN 'UPMC Standard Network' THEN 'The UPMC Standard Network gives you access to many high-quality'
      END AS Network_Consumer_Desc, -- NETWORK_CONSUMER_DESC

      CASE SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING
        WHEN 'UPMC Partner Network'  THEN 'In Network ONLY'
        WHEN 'UPMC Select Network'   THEN 'In Network ONLY'
        WHEN 'UPMC Premium Network'  THEN 'In Network, Out of Network'
        WHEN 'UPMC Standard Network' THEN 'In Network ONLY'
      END AS Coverage, -- COVERAGE

      CASE SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING
        WHEN 'UPMC Partner Network'  THEN 'All of our Bronze, Silver, and Gold plans'
        WHEN 'UPMC Select Network'   THEN 'All of our Bronze, Silver, and Gold plans'
        WHEN 'UPMC Premium Network'  THEN 'All of our Bronze, Silver, and Gold plans'
        WHEN 'UPMC Standard Network' THEN 'Bronze Plans'
      END AS Plan_Options, -- PLAN_OPTIONS

      '' AS Web_image_Filename_Net_Size, -- WEB_IMAGE_FILENAME_NET_SIZE
      '' AS Web_image_Filename_Net_map,  -- WEB_IMAGE_FILENAME_NET_MAP
      '' AS Web_image_Filename_Net_pdf,  -- WEB_IMAGE_FILENAME_NET_PDF

      CASE SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING
        WHEN 'UPMC Partner Network'  THEN '44'
        WHEN 'UPMC Select Network'   THEN '34'
        WHEN 'UPMC Premium Network'  THEN '32'
        WHEN 'UPMC Standard Network' THEN '33'
      END AS K_Value_Subprod_Key, -- K_VALUE_SUBPROD_KEY

      '' AS Dental_Network_K_Value, -- DENTAL_NETWORK_K_VALUE
      '' AS Dental_Network_URL,     -- DENTAL_NETWORK_URL
      '' AS Vision_Network_K_Value, -- VISION_NETWORK_K_VALUE
      '' AS Vision_Network_URL,     -- VISION_NETWORK_URL

      CASE SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network:ProviderNetworkMap.ProviderNetworkList[0].ProviderNetworkName::STRING
        WHEN 'UPMC Partner Network'  THEN 'https://findcare.upmchealthplan.com/find?type=shop&network=Partner'
        WHEN 'UPMC Select Network'   THEN 'https://findcare.upmchealthplan.com/find?type=shop&network=Select'
        WHEN 'UPMC Premium Network'  THEN 'https://findcare.upmchealthplan.com/find?type=shop&network=Premium'
        WHEN 'UPMC Standard Network' THEN 'https://findcare.upmchealthplan.com/find?type=shop&network=Standard'
      END AS CMS_Prov_Search_URL, -- CMS_PROV_SEARCH_URL

      SIMPLIFY_PLAN_PACKAGE.INSERT_DATETIME AS Update_Date,
      SIMPLIFY_PLAN_PACKAGE.INSERT_DATETIME AS LOAD_DATE,
      'Snowflake' AS Update_User -- UPDATE_USER
    FROM NETWORK.SIMPLIFY_PLAN_PACKAGE
    INNER JOIN NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW 
      ON SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY = SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW.SIMPLIFY_PLAN_PACKAGE_KEY
    WHERE 1=1
      AND LENGTH(TRIM(Ben_Yr)) > 0  -- Only enforce non-empty year here; year filtering happens in final SELECT
),

NETDEDUPE AS (
    /* Preserve original dedupe approach */
    SELECT * FROM net
    GROUP BY
        SIMPLIFY_PLAN_PACKAGE_KEY,
        DOCUMENT_ID,
        Network_ID,
        Ben_Yr,
        Market,
        IN_Display,
        Net_Serv_Descr,
        OON_Display,
        L2_Display,
        IN_Tier_name,
        OON_Tier_name,
        L2_Tier_name,
        NetworkSort,
        Network_Display_Name,
        Network_Consumer_Desc,
        Coverage,
        Web_image_Filename_Net_Size,
        Web_image_Filename_Net_map,
        Web_image_Filename_Net_pdf,
        K_Value_Subprod_Key,
        Dental_Network_K_Value,
        Dental_Network_URL,
        Vision_Network_K_Value,
        Vision_Network_URL,
        CMS_Prov_Search_URL,
        Update_Date,
        LOAD_DATE,
        Update_User,
        plan_options
),

RankedRows AS (
    SELECT 
        v.*,
        ROW_NUMBER() OVER (PARTITION BY network_id, market ORDER BY UPDATE_DATE DESC, DOCUMENT_ID) AS rn
    FROM NETDEDUPE v
    WHERE 1=1
)

SELECT 
    SIMPLIFY_PLAN_PACKAGE_KEY,
    DOCUMENT_ID,
    NETWORK_ID,
    BEN_YR,
    MARKET,
    IN_DISPLAY,
    NET_SERV_DESCR,
    OON_DISPLAY,
    L2_DISPLAY,
    IN_TIER_NAME,
    OON_TIER_NAME,
    L2_TIER_NAME,
    NETWORKSORT,
    NETWORK_DISPLAY_NAME,
    NETWORK_CONSUMER_DESC,
    COVERAGE,
    PLAN_OPTIONS,
    WEB_IMAGE_FILENAME_NET_SIZE,
    WEB_IMAGE_FILENAME_NET_MAP,
    WEB_IMAGE_FILENAME_NET_PDF,
    K_VALUE_SUBPROD_KEY,
    DENTAL_NETWORK_K_VALUE,
    DENTAL_NETWORK_URL,
    VISION_NETWORK_K_VALUE,
    VISION_NETWORK_URL,
    CMS_Prov_SEARCH_URL,
    UPDATE_DATE,
    LOAD_DATE,
    UPDATE_USER
FROM RankedRows
WHERE 
    rn = 1
    AND TRY_TO_NUMBER(TRIM(Ben_Yr)) >= 2025      -- ← Include 2025, 2026, and any future year
    AND Market IS NOT NULL
    AND Market IN ('IND','INDIVIDUAL')
;