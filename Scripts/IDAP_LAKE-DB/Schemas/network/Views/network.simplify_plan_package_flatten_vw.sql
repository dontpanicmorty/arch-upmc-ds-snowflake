CREATE OR REPLACE VIEW NETWORK.SIMPLIFY_PLAN_PACKAGE_FLATTEN_VW(
    MASTER_PLAN_ID,
    SIMPLIFY_PLAN_PACKAGE_KEY,
    DOCUMENT_ID,
    REFRESH_DT,
    PACKAGE_EFF_DATE,
    PLAN_EFF_DATE,
    BEN_YR,
    MARKET,
    PRODUCT_CATEGORY,
    PRODUCT_TYPE,
    DISPLAY,
    BENEFITPLANNUMBER,
    PRODUCT_ID,
    PLANTYPE,
    LEGALENTITY,
    CHANNEL,
    RX_RIDER,
    DENTAL_VISION,
    DENTAL_RIDER,
    VISION_RIDER,
    METAL,
    METAL_SORT,
    HIOSPLANID,
    HIOSSTDCOMPONENTID,
    VARIANTID,
    QHP_ID,
    CSRVARIATIONTYPE,
    PLANCODE,
    PLANCODECHANNEL,
    NETWORK_ID,
    MARKETINGPORTFOLIO,
    PACKAGE_NAME,
    MARKETINGPLANNAME,
    MARKETINGPLANNAME_SHORT,
    UPDATE_DT,
    UPDATE_USER,
    PRESALESBCFILENAME,
    ROC_FILENAME,
    SOB_FILENAME,
    PLAN_BROCHURE_FILENAME,
    URL_CMS_PLAN_DETAILS,
    URL_CMS_SBC,
    DENTAL_SOB,
    VISION_SOB,
    URL_CMS_FORMULARY,
    POLICY,
    POLICY_FILENAME,
    COC,
    COC_FILENAME,
    RX_RIDER_FILENAME
) COMMENT='Parses plan data from JSON; keeps most-recent row per QHP_ID+BEN_YR so 2025 is not overwritten by 2026'
AS
WITH
-- use full table (no current-row dependency)
SPP AS (
  SELECT *
  FROM NETWORK.SIMPLIFY_PLAN_PACKAGE
),

Product_Key AS (
  SELECT
    s.SIMPLIFY_PLAN_PACKAGE_KEY                                        AS SIMPLIFY_PLAN_PACKAGE_KEY,
    s.JSON_DATA:Result.Data.FormInstanceID::NUMBER                     AS pk_FormInstanceID,
    MAX(s.INSERT_DATETIME)                                             AS pk_Update_Dt,

s.JSON_DATA:Result.Data.JSON.PackageSelection.PackageEffectiveDate::STRING          AS Package_effective_Date,
s.JSON_DATA:Result.Data.JSON.ProductRules.PlanInformation.PlanEffectiveDate::STRING AS Plan_effective_Date,


    -- Ben_Yr — MEDICAL no longer requires Rx; Dental/Vision use new fallbacks 
MAX(
  CASE
    WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
      THEN SUBSTRING(
             COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING,
               s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
             ),
             7, 4
           )

    WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
      THEN SUBSTRING(
             COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.PlanEffectiveDate::STRING,
               s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::STRING,
               s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
             ),
             7, 4
           )

    WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
      THEN SUBSTRING(
             COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.PlanEffectiveDate::STRING,
               s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::STRING,
               s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
             ),
             7, 4
           )

    ELSE SUBSTRING(
           s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,
           7, 4
         )
  END
) AS pk_Ben_Yr,

    -- PackageName (still from PackageSelection) 
    /*CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
    END                                                                AS pk_PackageName,*/

    -- PackageName (directly from PackageSelection)
CASE
  WHEN TRIM(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING) IS NOT NULL
       AND TRIM(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING) <> ''
    THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
  ELSE NULL
END AS pk_PackageName,


    -- PlanName — add new *ProductSelection.FolderName* fallbacks 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.FolderName::STRING,  -- (if present in new format)
               s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.PlanName::STRING,                -- legacy best-effort
               s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanMarketingName::STRING                    -- last resort
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.FolderName::STRING,   -- NEW JSON
               s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanName::STRING
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.FolderName::STRING,   -- NEW JSON
               s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanName::STRING
             )
      ELSE ''
    END                                                                AS pk_PlanName,

    -- IDs for medical (now triggered by Medical only — Rx not required) 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING
      ELSE ''
    END                                                                AS pk_HIOSPlanID,

    -- NEW: 14-char Standard Component ID for component-level matching 
    COALESCE(
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStandardComponentID::STRING,
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStdComponentID::STRING
    )                                                                  AS pk_HIOSStdComponentID,

    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING
      ELSE ''
    END                                                                AS pk_VariantID,

    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::STRING
      ELSE ''
    END                                                                AS pk_Network_ID

  FROM SPP s

  -- Year filter must match the Ben_Yr logic above 
 -- Year filter must match the Ben_Yr logic above 
WHERE TRY_TO_NUMBER(
        CASE
          WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
            THEN SUBSTRING(
                   COALESCE(
                     s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING,
                     s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
                   ),
                   7, 4
                 )
          WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
            THEN SUBSTRING(
                   COALESCE(
                     s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.PlanEffectiveDate::STRING,
                     s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::STRING,
                     s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
                   ),
                   7, 4
                 )
          WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
            THEN SUBSTRING(
                   COALESCE(
                     s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.PlanEffectiveDate::STRING,
                     s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::STRING,
                     s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
                   ),
                   7, 4
                 )
          ELSE SUBSTRING(
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,
                 7, 4
               )
        END
      ) >= 2025

  GROUP BY
    s.SIMPLIFY_PLAN_PACKAGE_KEY,
    s.JSON_DATA:Result.Data.FormInstanceID,
    s.JSON_DATA:Result.Data.JSON.PackageSelection.PackageEffectiveDate,
    s.JSON_DATA:Result.Data.JSON.ProductRules.PlanInformation.PlanEffectiveDate,

    -- pk_Ben_Yr CASE — must match SELECT exactly 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
        THEN SUBSTRING(
               COALESCE(
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING,
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
               ), 7, 4
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
        THEN SUBSTRING(
               COALESCE(
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.PlanEffectiveDate::STRING,
                 s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::STRING,
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
               ), 7, 4
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
        THEN SUBSTRING(
               COALESCE(
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.PlanEffectiveDate::STRING,
                 s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::STRING,
                 s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
               ), 7, 4
             )
      ELSE SUBSTRING(
             s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,
             7, 4
           )
    END,

    -- pk_PackageName CASE 
    CASE
  WHEN TRIM(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING) IS NOT NULL
       AND TRIM(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING) <> ''
    THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
  ELSE NULL
END,

   /* CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
    END,*/

    -- pk_PlanName CASE 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.PlanName::STRING,
               s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanMarketingName::STRING
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanName::STRING
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanName::STRING
             )
      ELSE ''
    END,

    -- pk_HIOSPlanID CASE 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING
      ELSE ''
    END,

    -- NEW: pk_HIOSStdComponentID expression (must mirror SELECT) 
    COALESCE(
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStandardComponentID::STRING,
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStdComponentID::STRING
    ),

    -- pk_VariantID CASE 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING
      ELSE ''
    END,

    -- pk_Network_ID CASE 
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::STRING
      ELSE ''
    END
),

Product_Category AS (
  SELECT
    pk.SIMPLIFY_PLAN_PACKAGE_KEY,
    pk.pk_FormInstanceID                         AS pc_FormInstanceID,
    pk.pk_Update_Dt                              AS pc_Update_Dt,
    pk.Package_effective_Date,
    pk.Plan_effective_Date,

    pk.pk_Ben_Yr         AS pc_Ben_Yr,
    pk.pk_PackageName     AS pc_PackageName,
    pk.pk_PlanName        AS pc_PlanName,
    pk.pk_HIOSPlanID      AS pc_HIOSPlanID,
    pk.pk_VariantID       AS pc_VariantID,
    pk.pk_Network_ID      AS pc_Network_ID,

    CONCAT(
      CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' THEN 'Medical' ELSE '' END,
      CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::STRING)='TRUE' THEN 'Rx' ELSE '' END,
      CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE' THEN 'Dental' ELSE '' END,
      CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 'Vision' ELSE '' END,
      CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferHearingProduct::STRING)='TRUE' THEN 'Hearing' ELSE '' END
    ) AS pc_Product_Category
  FROM SPP s
  JOIN Product_Key pk
    ON pk.SIMPLIFY_PLAN_PACKAGE_KEY = s.SIMPLIFY_PLAN_PACKAGE_KEY
   AND pk.pk_FormInstanceID         = s.JSON_DATA:Result.Data.FormInstanceID::NUMBER
  WHERE
    -- MEDICAL (incl. MedicalRx): don't require VariantID—keep rows even if CSR missing
    (
      CONCAT(
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' THEN 'Medical' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::STRING)='TRUE' THEN 'Rx' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE' THEN 'Dental' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 'Vision' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferHearingProduct::STRING)='TRUE' THEN 'Hearing' ELSE '' END
      ) IN ('MedicalRx','Medical')
      AND NULLIF(
            TRIM(COALESCE(pk.pk_HIOSStdComponentID, pk.pk_HIOSPlanID)),
            ''
          ) IS NOT NULL
      -- pk.pk_VariantID not required anymore
    )

    OR

    -- DENTAL / VISION keep requirement on names (unchanged)
    (
      CONCAT(
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' THEN 'Medical' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::STRING)='TRUE' THEN 'Rx' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE' THEN 'Dental' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 'Vision' ELSE '' END,
        CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferHearingProduct::STRING)='TRUE' THEN 'Hearing' ELSE '' END
      ) IN ('Dental','Vision')
      AND LENGTH(TRIM(pk.pk_PackageName)) > 0
      AND LENGTH(TRIM(pk.pk_PlanName))    > 0
    )
)

, pre_final AS (
  SELECT

    -- Ben_Yr
-- Ben_Yr
CASE
  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
    THEN SUBSTRING(
           COALESCE(
             s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING,
             s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
           ),
           7, 4
         )

  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
    THEN SUBSTRING(
           COALESCE(
             s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.PlanEffectiveDate::STRING,
             s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::STRING,
             s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
           ),
           7, 4
         )

  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
    THEN SUBSTRING(
           COALESCE(
             s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.PlanEffectiveDate::STRING,
             s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::STRING,
             s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING
           ),
           7, 4
         )

  ELSE SUBSTRING(
         s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,
         7, 4
       )
END AS Ben_Yr,

    -- Names
    /* CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
       AND UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::STRING) = 'TRUE'
        THEN ''
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
    END AS PackageName, */

    CASE 
  WHEN TRIM(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING) IS NOT NULL
       AND TRIM(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING) <> ''
    THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::STRING
  ELSE NULL
END AS PackageName,


    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
       AND UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::STRING) = 'TRUE'
        THEN ''
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanName::STRING
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanName::STRING
             )
    END AS PlanName,

    -- IDs from QHPDetails (10-char HIOS plan id)
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING
      ELSE ''
    END AS HIOSPlanID,

    -- Raw CSR label (as-is from JSON, preserved)
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING
      ELSE ''
    END AS VariantID,

    -- Network (keep blanks if truly blank)
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN COALESCE(s.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::STRING,'')
      ELSE ''
    END AS Network_ID,

    -- passthrough keys & timestamps
    s.SIMPLIFY_PLAN_PACKAGE_KEY AS SPP_KEY,
    s.JSON_DATA:Result.Data.FormInstanceID::NUMBER AS FormInstanceID,
    s.INSERT_DATETIME AS Update_Dt,


    -- Market (prefer ProductRules, fallback PackageSelection)
      CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'   THEN
        CASE
          WHEN REGEXP_LIKE(
                 UPPER(
                   COALESCE(
                     NULLIF(s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING,''),
                     NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                   )
                 ), 'INDIVIDUAL'
               ) THEN 'IND'
          WHEN UPPER(
                 COALESCE(
                   NULLIF(s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING,''),
                   NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                 )
               ) = 'SMALL GROUP' THEN 'SG'
          WHEN UPPER(
                 COALESCE(
                   NULLIF(s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING,''),
                   NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                 )
               ) = 'LARGE GROUP' THEN 'LG'
          ELSE NULL
        END
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE' THEN
        CASE
          WHEN REGEXP_LIKE(
                 UPPER(
                   COALESCE(
                     NULLIF(s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.MarketSegment::STRING,''),
                     NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                   )
                 ), 'INDIVIDUAL'
               ) THEN 'IND'
          WHEN UPPER(
                 COALESCE(
                   NULLIF(s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.MarketSegment::STRING,''),
                   NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                 )
               ) = 'SMALL GROUP' THEN 'SG'
          WHEN UPPER(
                 COALESCE(
                   NULLIF(s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.MarketSegment::STRING,''),
                   NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                 )
               ) = 'LARGE GROUP' THEN 'LG'
          ELSE NULL
        END
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE' THEN
        CASE
          WHEN REGEXP_LIKE(
                 UPPER(
                   COALESCE(
                     NULLIF(s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.MarketSegment::STRING,''),
                     NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                   )
                 ), 'INDIVIDUAL'
               ) THEN 'IND'
          WHEN UPPER(
                 COALESCE(
                   NULLIF(s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.MarketSegment::STRING,''),
                   NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                 )
               ) = 'SMALL GROUP' THEN 'SG'
          WHEN UPPER(
                 COALESCE(
                   NULLIF(s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.MarketSegment::STRING,''),
                   NULLIF(s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketSegment::STRING,'')
                 )
               ) = 'LARGE GROUP' THEN 'LG'
          ELSE NULL
        END
    END AS Market,

    -- Product category + display flags

    CASE
  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
   AND UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
   AND UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
    THEN 'MED_DV'

  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
    THEN 'VIS'

  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
    THEN 'DENT'

  WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
    THEN 'MED'
END AS Product_Category,

    /* CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 'VIS'
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE' THEN 'DENT'
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' THEN 'MED'
    END AS Product_Category, */

   /* CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE' THEN 'Buy-Up'
        --OR UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 'Yes'
      ELSE 'NULL' END AS Product_Type, */

    s.JSON_DATA:Result.Data.JSON.Summary.ProductType::STRING AS Product_Type,


    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        OR UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 'NO'
      ELSE 'YES' END AS Display,

    -- Plan/Product bits
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN TRIM(s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.ProductID::STRING)
      ELSE '' END AS BenefitPlanNumber,

    s.JSON_DATA:Result.Data.JSON.ProductRules.PlanInformation.ProductID::STRING AS Product_ID,

    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.TypeofPlan::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.TypeofPlan::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.TypeOfPlan::STRING
    END AS PlanType,

    s.JSON_DATA:Result.Data.JSON.PackageSelection.LegalEntity::STRING AS LegalEntity,

    -- Channel
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND
           s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING IN
           ('Limited Cost Sharing Plan Variation','Zero Cost Sharing Plan Variation','On Exchange Plan',
            '87% AV Level Silver Plan','73% AV Level Silver Plan','94% AV Level Silver Plan')
        THEN 'On-Exchange'
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND
           s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING IN ('Off Exchange Plan','00')
        THEN 'Off Exchange'
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        OR UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN 'Off Exchange'
    END AS Channel,

    -- Rx rider name
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:RxProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.RxProductRules:RxProductInformation.PlanName::STRING
             )
      ELSE ''
    END AS Rx_Rider,

    -- Riders
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PediatricDentalVisionRiderCode::STRING
      ELSE '' END AS Dental_Vision,

    CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
         THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanCode::STRING ELSE 'NULL' END AS Dental_Rider,
    CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
         THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanCode::STRING ELSE 'NULL' END AS Vision_Rider,

    -- Metal & sort
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.MetalTier::STRING
      ELSE '' END AS Metal,

    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.MetalTier::STRING='Platinum'     THEN 4
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.MetalTier::STRING='Gold'         THEN 3
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.MetalTier::STRING='Silver'       THEN 2
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.MetalTier::STRING='Bronze'       THEN 1
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' AND s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.MetalTier::STRING='Catastrophic' THEN 5
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        OR UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN 9
      ELSE 6
    END AS Metal_Sort,

    -- Other IDs
    s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSProductID::STRING AS HIOSProductID,
COALESCE(
  s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING,
  s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStandardComponentID::STRING,
  s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStdComponentID::STRING
) AS HIOSStdComponentID,


    -- Normalized CSR once
    UPPER(TRIM(s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING)) AS CSR_RAW_UPPER,

    -- CSR mapped to 2-digit code
    CASE
      WHEN CSR_RAW_UPPER = 'OFF EXCHANGE PLAN'                    THEN '00'
      WHEN CSR_RAW_UPPER = 'ON EXCHANGE PLAN'                     THEN '01'
      WHEN CSR_RAW_UPPER = 'ZERO COST SHARING PLAN VARIATION'     THEN '02'
      WHEN CSR_RAW_UPPER = 'LIMITED COST SHARING PLAN VARIATION'  THEN '03'
      WHEN CSR_RAW_UPPER = '73% AV LEVEL SILVER PLAN'             THEN '04'
      WHEN CSR_RAW_UPPER = '87% AV LEVEL SILVER PLAN'             THEN '05'
      WHEN CSR_RAW_UPPER = '94% AV LEVEL SILVER PLAN'             THEN '06'
      WHEN REGEXP_LIKE(CSR_RAW_UPPER, '^[0-9]{2}$')               THEN CSR_RAW_UPPER
      ELSE '00'
    END AS CSR2,

    -- VariantIDCSR = 2-digit code
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' THEN CSR2
      ELSE '' END AS VariantIDCSR,

    -- Business-friendly CSR label
    CASE
      WHEN CSR_RAW_UPPER IN ('OFF EXCHANGE PLAN','ON EXCHANGE PLAN','00','01') THEN 'STD'
      WHEN CSR_RAW_UPPER = 'LIMITED COST SHARING PLAN VARIATION'               THEN 'LCS'
      WHEN CSR_RAW_UPPER = 'ZERO COST SHARING PLAN VARIATION'                  THEN 'ZCS'
      WHEN CSR_RAW_UPPER = '73% AV LEVEL SILVER PLAN'                           THEN '73'
      WHEN CSR_RAW_UPPER = '87% AV LEVEL SILVER PLAN'                           THEN '87'
      WHEN CSR_RAW_UPPER = '94% AV LEVEL SILVER PLAN'                           THEN '94'
      ELSE NULL
    END AS CSRVariationType,

    -- Base HIOS for QHP build (prefer 14-char std component, else 10-char plan id)
    COALESCE(
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStandardComponentID::STRING,
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSStdComponentID::STRING,
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING
    ) AS HIOS_BASE_FOR_QHP,

    -- Final QHP_ID build = base + CSR2
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN CONCAT(HIOS_BASE_FOR_QHP, CSR2)
      ELSE ''
    END AS QHP_ID,

    -- Plan code & channel
    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanCode::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE' THEN '?'
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE' THEN '?' END AS PlanCode,

    CASE
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE' THEN
        CASE s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::STRING
          WHEN 'Off Exchange Plan' THEN 'Off Exchange'
          WHEN '00'                THEN 'Off Exchange'
          WHEN 'Limited Cost Sharing Plan Variation' THEN 'On-Exchange'
          WHEN 'Zero Cost Sharing Plan Variation'    THEN 'On-Exchange'
          WHEN 'On Exchange Plan'                    THEN 'On-Exchange'
          WHEN '87% AV Level Silver Plan'            THEN 'On-Exchange'
          WHEN '73% AV Level Silver Plan'            THEN 'On-Exchange'
          WHEN '94% AV Level Silver Plan'            THEN 'On-Exchange'
        END
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING)='TRUE'
        OR UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING)='TRUE'
        THEN 'Off Exchange'
    END AS PlanCodeChannel,

    -- Marketing names
    CASE 
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanMarketingName::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.DentalMarketingPlanName::STRING
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.FolderName::STRING,
               s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.VisionMarketingPlanName::STRING
             )
    END AS MarketingPlanName,

    CASE 
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING) = 'TRUE'
        THEN s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanMarketingNameShort::STRING
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalProductSelection.SelectDentalProduct::STRING,
               s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.DentalPlanLevel::STRING
             )
      WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::STRING) = 'TRUE'
        THEN COALESCE(
               s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionProductSelection.SelectVisionProduct::STRING,
               s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.VisionPlanLevel::STRING
             )
    END AS MarketingPlanName_Short,

    -- Descriptions & docs
COALESCE(
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocumentFileNames.SBCFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.ProductRules:MedicalDocumentFileNames.SBCFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanVariantLevelURLsList.SBCFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:SBCFileName::STRING,
  'NULL'
) AS PreSaleSBCfilename,

COALESCE(
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocumentFileNames.MedicalROCFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.ProductRules:MedicalDocumentFileNames.MedicalROCFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:ROCFileName::STRING,
  'NULL'
) AS ROC_Filename,

COALESCE(
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocumentFileNames.MedicalSOBFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.ProductRules:MedicalDocumentFileNames.MedicalSOBFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:SOBFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanVariantLevelURLsList.SummaryOfBenefits::STRING,
  'NULL'
) AS SOB_Filename,

COALESCE(
  s.JSON_DATA:Result.Data.JSON.QHPDetails.PlanVariantLevelURLsList.PlanBrochure::STRING,
  s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:PlanBrochure::STRING,
  'NULL'
) AS Plan_Brochure_Filename,


    -- URLs
    COALESCE(
      CONCAT(
        'https://www.upmchealthplan.com/marketplace/details.aspx?plan=',
        SUBSTRING(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,7,4),
        '_IND_', s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING
      ),
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanVariantLevelURLsList.PlanDetailsURL::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:PlanDetailsURL::STRING
    ) AS URL_CMS_Plan_Details,

    COALESCE(
      CONCAT(
        'https://www.upmchealthplan.com/marketplace/',
        SUBSTRING(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,7,4),
        '_RxList.aspx'
      ),
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanVariantLevelURLsList.FormularyURL::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:FormularyURL::STRING
    ) AS URL_CMS_Formulary,

    -- Dental / Vision SOB filenames (NULL if not present)
COALESCE(
  s.JSON_DATA:Result.Data.JSON.PackageSelection:DentalFileNames.DentalSOBFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalFilenames.DentalSOBFileName::STRING,
  'NULL'
) AS Dental_SOB,

COALESCE(
  s.JSON_DATA:Result.Data.JSON.PackageSelection:VisionFileNames.VisionSOBFileName::STRING,
  s.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionFilenames.VisionSOBFileName::STRING,
  'NULL'
) AS Vision_SOB,


    COALESCE(
      CONCAT(
        'https://www.upmchealthplan.com/marketplace/details.aspx?plan=',
        s.JSON_DATA:Result.Data.JSON.PackageSelection:PlanCode::STRING,'_',
        s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.TypeofPlan::STRING,'_RX',
        COALESCE(
          s.JSON_DATA:Result.Data.JSON.PackageSelection:RxProductSelection.FolderName::STRING,
          s.JSON_DATA:Result.Data.JSON.RxProductRules:RxProductInformation.PlanName::STRING
        ),'_',
        s.JSON_DATA:Result.Data.JSON.PackageSelection:PediatricDentalVisionRiderCode::STRING,'_',
        SUBSTRING(s.JSON_DATA:Result.Data.JSON.PackageSelection:PackageEffectiveDate::STRING,7,4),'_',
        s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::STRING
      ),
      s.JSON_DATA:Result.Data.JSON.QHPDetails:PlanVariantLevelURLsList.SBCURL::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:SBCURL::STRING
    ) AS URL_CMS_SBC,

    -- Policy / files
    CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
         THEN SUBSTRING(s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.PolicyFormNumber::STRING,6,4) ELSE NULL END AS Policy1,
    CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
         THEN s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.PolicyFormNumber::STRING ELSE NULL END AS Policy_Filename,

    COALESCE(
    s.JSON_DATA:Result.Data.JSON.ProductRules:MedicalDocumentFileNames.COCFileName::STRING,
    s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocs:COCFileName::STRING,
    s.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalDocumentFileNames.COCFilename::STRING,
    'NULL'
) AS COC_Filename,


    CASE WHEN UPPER(s.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::STRING)='TRUE'
         THEN s.JSON_DATA:Result.Data.JSON.RxProductRules:RxProductInformation.RxSOBRiderFileName::STRING
         ELSE NULL END AS Rx_Rider_Filename,

    -- MarketingPortfolio
    COALESCE(
      s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketingPortfolio::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:MarketingPortfolio::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:NetworkServiceDescription::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:ServiceAreaName::STRING,
      s.JSON_DATA:Result.Data.JSON.PackageSelection:FutureYearPackageDescription::STRING
    ) AS MarketingPortfolio,

    -- bring forward effective dates for final select
-- bring forward effective dates for final select
COALESCE(
  pc.Package_effective_Date,
  s.JSON_DATA:Result.Data.JSON.PackageSelection.PackageEffectiveDate::STRING
) AS Package_effective_Date,

COALESCE(
  pc.Plan_effective_Date,
  s.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.PlanEffectiveDate::STRING
) AS Plan_effective_Date


  FROM SPP s
  LEFT JOIN Product_Category pc
    ON pc.SIMPLIFY_PLAN_PACKAGE_KEY = s.SIMPLIFY_PLAN_PACKAGE_KEY
   AND pc.pc_FormInstanceID         = s.JSON_DATA:Result.Data.FormInstanceID::NUMBER
)


SELECT
  MD5(CONCAT(
      COALESCE(pc.pc_Ben_Yr, pf.Ben_Yr),
      COALESCE(pc.pc_PackageName, pf.PackageName),
      COALESCE(pc.pc_PlanName, pf.PlanName),
      COALESCE(pc.pc_HIOSPlanID, pf.HIOSPlanID),
      COALESCE(pc.pc_VariantID, pf.VariantID),
      COALESCE(pc.pc_Network_ID, pf.Network_ID)
  ))                                                                                                     AS MASTER_PLAN_ID,
  COALESCE(pc.SIMPLIFY_PLAN_PACKAGE_KEY, pf.SPP_KEY)                                                     AS SIMPLIFY_PLAN_PACKAGE_KEY,
  pf.FormInstanceID                                                                                      AS DOCUMENT_ID,
  pf.Update_Dt                                                                                           AS REFRESH_DT,
  COALESCE(pc.Package_effective_Date, pf.Package_effective_Date)                                         AS PACKAGE_EFF_DATE,
  COALESCE(pc.Plan_effective_Date,    pf.Plan_effective_Date)                                            AS PLAN_EFF_DATE,

  NULLIF(TRIM(pf.Ben_Yr), '')                                                                            AS BEN_YR,          -- EDIT 1

  pf.Market                                                                                              AS MARKET,
  pf.Product_Category                                                                                    AS PRODUCT_CATEGORY,
  pf.Product_Type                                                                                        AS PRODUCT_TYPE,
  pf.Display                                                                                             AS DISPLAY,
  RIGHT(pf.BenefitPlanNumber, 4)                                                                         AS BENEFITPLANNUMBER,
  pf.Product_ID                                                                                          AS PRODUCT_ID,
  pf.PlanType                                                                                            AS PLANTYPE,
  pf.LegalEntity                                                                                         AS LEGALENTITY,
  pf.Channel                                                                                             AS CHANNEL,
  pf.Rx_Rider                                                                                            As RX_RIDER,
  pf.Dental_Vision                                                                                       AS DENTAL_VISION,
  pf.Dental_Rider                                                                                        AS DENTAL_RIDER,
  pf.Vision_Rider                                                                                        AS VISION_RIDER,
  pf.Metal                                                                                               AS METAL,
  pf.Metal_Sort                                                                                          AS METAL_SORT,
  LEFT(pf.HIOSPlanID,10)                                                                                 AS HIOSPLANID,
  pf.HIOSStdComponentID                                                                                  AS HIOSSTDCOMPONENTID,
  pf.VariantIDCSR                                                                                        AS VARIANTID,
  pf.QHP_ID                                                                                              AS QHP_ID,
  pf.CSRVariationType                                                                                    AS CSRVARIATIONTYPE,
  pf.PlanCode                                                                                            AS PLANCODE,
  pf.PlanCodeChannel                                                                                     AS PLANCODECHANNEL,
  COALESCE(pc.pc_Network_ID, pf.Network_ID)                                                              AS NETWORK_ID,
  pf.MarketingPortfolio                                                                                  AS MARKETINGPORTFOLIO,
  pf.PackageName                                                                                         AS PACKAGE_NAME,
  pf.MarketingPlanName                                                                                   AS MARKETINGPLANNAME,
  pf.MarketingPlanName_short                                                                             AS MARKETINGPLANNAME_SHORT,
  pf.Update_Dt                                                                                           AS UPDATE_DT,
  'Snowflake'                                                                                            AS UPDATE_USER,
  pf.PreSaleSBCfilename                                                                                  AS PRESALESBCFILENAME,
  pf.ROC_Filename                                                                                        AS ROC_FILENAME,
  pf.SOB_Filename                                                                                        AS SOB_FILENAME,
  pf.Plan_Brochure_Filename                                                                              AS PLAN_BROCHURE_FILENAME,
  pf.URL_CMS_Plan_Details                                                                                AS URL_CMS_PLAN_DETAILS,
  pf.URL_CMS_SBC                                                                                         AS URL_CMS_SBC,
  pf.Dental_SOB                                                                                          AS DENTAL_SOB,
  pf.Vision_SOB                                                                                          AS VISION_SOB,
  pf.URL_CMS_Formulary                                                                                   AS URL_CMS_FORMULARY,
  pf.Policy1                                                                                             AS "POLICY",
  pf.Policy_Filename                                                                                     AS POLICY_FILENAME,
  ''                                                                                                     AS COC,
  pf.COC_Filename                                                                                        AS COC_FILENAME,
  pf.Rx_Rider_Filename                                                                                   AS RX_RIDER_FILENAME
FROM pre_final pf
LEFT JOIN Product_Category pc
  ON pc.pc_FormInstanceID         = pf.FormInstanceID
 AND pc.SIMPLIFY_PLAN_PACKAGE_KEY = pf.SPP_KEY
WHERE NULLIF(TRIM(pf.QHP_ID),'') IS NOT NULL
  AND COALESCE(TRY_TO_NUMBER(pf.Ben_Yr), 0) >= 2025
  AND pf.Market = 'IND'
  AND NOT (
        COALESCE(pf.PackageName,        '') ILIKE '%TEST%'
     OR COALESCE(pf.MarketingPlanName,  '') ILIKE '%TEST%'
     OR COALESCE(pf.MarketingPlanName_Short, '') ILIKE '%TEST%'
  )
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY pf.QHP_ID, pf.Ben_Yr
  ORDER BY pf.Update_Dt DESC, pf.FormInstanceID DESC
) = 1;