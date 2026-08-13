CREATE OR REPLACE VIEW NETWORK.SIMPLIFY_PLAN_PACKAGE_VW
(SIMPLIFY_PLAN_PACKAGE_KEY
    ,INSERT_DATETIME
    ,DOCUMENT_ID
    ,Summary
    ,PackageSelection
    ,ProductRules
    ,Network
    ,GeneralCostShare
    ,StandardServices
    ,AdditionalServices
    ,CascadingCostShare
    ,SlidingCostShare
    ,Limits
    ,BenefitReviewGuardrail
    ,BenefitReview
    ,CombinedCostShare
    ,RxProductRules
    ,RxNetworkandTierSelection
    ,RxNetworkTier
    ,RxGeneralCostShare
    ,RxBenefitReview
    ,DentalProductRules
    ,DentalNetworkandClass
    ,DentalDeductibleandMaximum
    ,DentalClassCostShare
    ,DentalLimits
    ,DentalBenefitReview
    ,QHPDetails
    ,AdditionalBenefitPrograms
    ,Riders
    ,AuditChecklist
    ,HSA
    ,VisionProductRules
    ,VisionNetworkSelection
    ,VisionDeductibleMaximum
    ,VisionLimits
    ,VisionBenefitReview
    ,AdditionalLensOptions
    ,Rates
    ,SystemConfiguration
    ,Networks 
)
AS (
      SELECT SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY AS SIMPLIFY_PLAN_PACKAGE_KEY
      ,SIMPLIFY_PLAN_PACKAGE.INSERT_DATETIME AS INSERT_DATETIME
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID::number AS DOCUMENT_ID
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Summary::variant AS Summary
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection::variant AS PackageSelection
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.ProductRules::variant AS ProductRules
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Network::variant AS Network
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.GeneralCostShare::variant AS GeneralCostShare
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.StandardServices::variant AS StandardServices
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.AdditionalServices::variant AS AdditionalServices
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.CascadingCostShare::variant AS CascadingCostShare
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.SlidingCostShare::variant AS SlidingCostShare
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Limits::variant AS Limits
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.BenefitReviewGuardrail::variant AS BenefitReviewGuardrail
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.BenefitReview::variant AS BenefitReview
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.CombinedCostShare::variant AS CombinedCostShare
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.RxProductRules::variant AS RxProductRules
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.RxNetworkandTierSelection::variant AS RxNetworkandTierSelection
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.RxNetworkTier::variant AS RxNetworkTier
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.RxGeneralCostShare::variant AS RxGeneralCostShare
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.RxBenefitReview::variant AS RxBenefitReview
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules::variant AS DentalProductRules
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalNetworkandClass::variant AS DentalNetworkandClass
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalDeductibleandMaximum::variant AS DentalDeductibleandMaximum
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalClassCostShare::variant AS DentalClassCostShare
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalLimits::variant AS DentalLimits
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalBenefitReview::variant AS DentalBenefitReview
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails::variant AS QHPDetails
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.AdditionalBenefitPrograms::variant AS AdditionalBenefitPrograms
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Riders::variant AS Riders
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.AuditChecklist::variant AS AuditChecklist
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.HSA::variant AS HSA
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules::variant AS VisionProductRules
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionNetworkSelection::variant AS VisionNetworkSelection
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionDeductibleMaximum::variant AS VisionDeductibleMaximum
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionLimits::variant AS VisionLimits
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionBenefitReview::variant AS VisionBenefitReview
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.AdditionalLensOptions::variant AS AdditionalLensOptions
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Rates::variant AS Rates
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.SystemConfiguration::variant AS SystemConfiguration
      ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.Networks::variant AS Networks
  FROM NETWORK.SIMPLIFY_PLAN_PACKAGE 
  INNER JOIN
  NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW
  ON SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY = SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW.SIMPLIFY_PLAN_PACKAGE_KEY
)
;