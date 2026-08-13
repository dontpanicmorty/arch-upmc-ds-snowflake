create or replace view NETWORK.SIMPLIFY_INNETWORK_FLATTEN_VW(
	QHP_ID,
	MASTER_PLAN_ID,
	UPDATE_DT,
	FORMINSTANCEID,
	UPDATE_USER,
	BEN_YR,
	PK_HIOSPLANID,
	MARKET,
	C_601_ANNUAL_DEDUCTIBLE_INDIVIDUAL_IN,
	C_601_INTEGER_ANNUALDED_IND,
	C_602_ANNUAL_DEDUCTIBLE_FAMILY_IN,
	C_602_INTEGER_ANNUALDED_FAM,
	C_603_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_IN,
	C_603_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_IN,
	C_604_ANNUAL_OUT_OF_POCKET_LIMIT2_FAMILY_IN,
	C_604_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT2_FAMILY_IN,
	C_605_HEALTH_INCENTIVE_ACCOUNT_INDIVIDUAL_IN,
	C_606_HEALTH_INCENTIVE_ACCOUNT_FAMILY_IN,
	C_607_PLAN_PAYMENT_LEVEL_IN,
	C_607_INTEGER_PLANPAYMENTLEVEL_IN,
	C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN,
	C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE,
	BEHAVIOR_HEALTH_OFFICE_VISIT_IN,
	C_633_EVISIT_IN,
	VIRTUAL_VISIT_LEVEL_4_IN,
	VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST,
	C_632_SPECIALIST_OFFICE_VISIT_IN,
	C_617_EMERGENCY_CARE_COVERAGE_IN,
	C_654_INPATIENT_IN,
	RETAIL_GENERIC,
	RETAIL_PREFERRED,
	RETAIL_NONPREFERRED,
	RETAIL_SPECIALTY,
	PHARMACY_BENEFITS,
	"R175#020=Rx_DED_IND",
	"R175#030=Rx_DED_FAM",
	RN
) as						
						
WITH Benepre						
AS(						
SELECT						
  MD5(CONCAT(SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
            )						
     ) AS pk_Master_Plan_ID						
     , 						
     SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails.PlanIdentifiers.HIOSProductID:: variant as QHP_ID,						
     						
     						
CASE 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN ''  						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN ''						
  END AS QHPID1 --pk_HIOSPlanID						
,						
      						
  SUBSTRING(
  COALESCE(
    SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::STRING,
    SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection.PackageEffectiveDate::STRING
  ),
  7,
  4
) AS pk_Ben_Yr,						
  'Snowflake' AS Update_User,						
   SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String AS pk_HIOSPlanID, 						
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String AS pk_VariantID, 
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.VarianceID::STRING AS pk_VarianceID,
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String AS pk_Network_ID, 						
  MAX(SIMPLIFY_PLAN_PACKAGE.INSERT_DATETIME) AS pk_Update_Dt, 						
  MAX(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID) AS pk_FormInstanceID ,						
CASE
  COALESCE(
    SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::STRING,
    SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection.MarketSegment::STRING
  )
  WHEN 'Small Group' THEN 'SG'
  WHEN 'Individual' THEN 'IND'
  WHEN 'Large Group' THEN 'LG'
END AS Market,					
max (						
  CASE						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Generic Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Copay Only'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCopay),'\.00$','') || ' Copayment for preferred generic medications.' 						
    WHEN RxBenefitService.value:NetworkName::String = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Generic Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Copay'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCopay),'\.00$','') || ' after Deductible for preferred generic medications.'						
    WHEN RxBenefitService.value:NetworkName::String = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Generic Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'No Cost'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay $0 for preferred generic medications.' 						
    WHEN RxBenefitService.value:NetworkName::String = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Generic Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible Only'						
      AND RxBenefitService.value:RxCopay::String = 'Not Applicable'						
    THEN 'You pay $0 after Deductible for preferred generic medications.' 						
    WHEN RxBenefitService.value:NetworkName::String = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Generic Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Coinsurance'						
      AND RxBenefitService.value:RxCoinsurance::String IS NOT NULL						
    THEN 'You pay '						
         || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCoinsurance), '\.00(%?)$', '\\1')						
         || ' after Deductible for preferred generic medications.'						
  END						
) AS RETAIL_GENERIC ,						
						
max(						
  CASE						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Brand Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Copay Only'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay ' ||  REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCopay),'\.00$','') || ' Copayment for preferred brand medications.' 						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Brand Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Copay'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCopay),'\.00$','') || ' after Deductible for preferred brand medications.'						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Brand Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'No Cost'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay $0 for preferred brand medications.' 						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Brand Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible Only'						
      AND RxBenefitService.value:RxCopay::String = 'Not Applicable'						
    THEN 'You pay $0 after Deductible for preferred brand medications.' 						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Preferred Brand Medications'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Coinsurance'						
      AND RxBenefitService.value:RxCoinsurance::String IS NOT NULL						
    THEN 'You pay '						
         || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCoinsurance), '\.00(%?)$', '\\1')						
         || ' after Deductible for preferred brand medications.'						
  END						
) AS RETAIL_PREFERRED						
,						
max(						
  CASE						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Non Preferred Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Copay Only'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCopay),'\.00$','') || ' Copayment for nonpreferred medications (brand and generic).' 						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Non Preferred Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Copay'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCopay),'\.00$','') || ' after Deductible for nonpreferred medications (brand and generic).'						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Non Preferred Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'No Cost'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'You pay $0 for nonpreferred medications (brand and generic).' 						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Non Preferred Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible Only'						
      AND RxBenefitService.value:RxCopay::String = 'Not Applicable'						
    THEN 'You pay $0 after Deductible for nonpreferred medications (brand and generic).' 						
    -- Deductible then Coinsurance						
    WHEN RxBenefitService.value:NetworkName::String = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Non Preferred Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Coinsurance'						
      AND RxBenefitService.value:RxCoinsurance::String IS NOT NULL						
    THEN 'You pay '						
         || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCoinsurance), '\.00(%?)$', '\\1')						
         || ' after Deductible for nonpreferred medications (brand and generic).'						
  END						
) AS RETAIL_NONPREFERRED						
,						
MAX(						
  CASE						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Specialty Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Coinsurance Only'						
      AND RxBenefitService.value:RxCopay::String = 'Not Applicable'						
      AND RxBenefitService.value:RxCoinsurance::String IS NOT NULL						
      AND RxBenefitService.value:DollarMax::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCoinsurance), '\.00(%?)$', '\\1') || ' for specialty medications (brand and generic) with a maximum of ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:DollarMax),'\.00$','') ||  ' per prescription.'						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Specialty Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible then Coinsurance'						
      AND RxBenefitService.value:RxCopay::String = 'Not Applicable'						
      AND RxBenefitService.value:RxCoinsurance::String IS NOT NULL						
      AND RxBenefitService.value:DollarMax::String IS NOT NULL						
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(RxBenefitService.value:RxCoinsurance), '\.00(%?)$', '\\1') || ' after Deductible for speciality medications (brand and generic).'					
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Specialty Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'No Cost'						
      AND RxBenefitService.value:RxCopay::String IS NOT NULL						
    THEN 'Covered at 100%. You pay $0 for specialty medications (brand and generic).' 						
    WHEN RxBenefitService.value:NetworkName::string = 'Member Cost Sharing'						
      AND RxBenefitService.value:NetworkTier::String <> 'OON'						
      AND RxBenefitService.value:RxTier::String = 'Specialty Medications - Brand and Generic'						
      AND RxBenefitService.value:RxTierType::String = 'Retail'						
      AND RxBenefitService.value:CostShareType::String = 'Deductible Only'						
      AND RxBenefitService.value:RxCopay::String = 'Not Applicable'						
    THEN 'You pay $0 after Deductible for specialty medications (brand and generic).' 						
  END						
) AS RETAIL_SPECIALTY						
						
,						
MAX(CASE						
  -- Not Covered						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'Not Covered'						
  THEN 'Not Covered.'						
						
  -- Coinsurance Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'						
						
  -- Deductible Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'Deductible Only'						
  THEN 'You pay $0 After Deductible.'						
						
  -- No Cost						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'No Cost'						
  THEN 'Covered at 100%; you pay $0.'						
						
  -- Deductible then Coinsurance						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'						
						
  -- Copay Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'Copay Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||						
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'						
						
  -- Deductible then Copay						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'						
ELSE 'Not Applicable.'						
END) AS C_654_Inpatient_IN,						
						
MAX(CASE						
  -- Not Covered						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'Not Covered'						
  THEN 'Not Covered.'						
						
  -- Coinsurance Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'						
						
  -- Deductible Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'Deductible Only'						
  THEN 'You pay $0 After Deductible.'						
						
  -- No Cost						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'No Cost'						
  THEN 'Covered at 100%; you pay $0.'						
						
  -- Deductible then Coinsurance						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'						
						
  -- Copay Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'Copay Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||						
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'						
						
  -- Deductible then Copay						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'						
ELSE 'Not Applicable.'						
END) AS Behavior_Health_Office_Visit_IN,						
						
MAX(CASE
  -- Not Covered                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Not Covered'                        
  THEN 'Not Covered.'                        
                        
  -- Coinsurance Only                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'                        
                        
  -- Deductible Only                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Deductible Only'                        
  THEN 'You pay $0 After Deductible.'                        
                        
  -- No Cost                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'No Cost'                        
  THEN 'Covered at 100%; you pay $0.'                        
                        
  -- Deductible then Coinsurance                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'                        
                        
  -- Copay Only                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Copay Only'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||                        
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'                        
                        
  -- Deductible then Copay                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'        
  
  -- Sliding Cost Share                    
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'                        
    AND BenefitService.value:CostShareType::string = 'Sliding Cost Share'                        
  THEN 'First visit Covered at 100%; you pay $0. Then, you pay $25 Copayment per visit.'    

  ELSE NULL
END) AS Virtual_Visit_Level_1_e_g_specialist,	
						
MAX(CASE						
  -- Not Covered						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Not Covered'						
  THEN 'Not Covered.'						
						
  -- Coinsurance Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'						
						
  -- Deductible Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Deductible Only'						
  THEN 'You pay $0 After Deductible.'						
						
  -- No Cost						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'No Cost'						
  THEN 'Covered at 100%; you pay $0.'						
						
  -- Deductible then Coinsurance						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'						
						
  -- Copay Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Copay Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||						
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'						
						
  -- Deductible then Copay						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'						
ELSE 'Not Applicable.'						
END) AS Virtual_Visit_Level_4_IN,						
						
MAX(CASE						
  -- Not Covered						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Not Covered'						
  THEN 'Not Covered.'						
						
  -- Coinsurance Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'						
						
  -- Deductible Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Deductible Only'						
  THEN 'You pay $0 After Deductible.'						
						
  -- No Cost						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'No Cost'						
  THEN 'Covered at 100%; you pay $0.'						
						
  -- Deductible then Coinsurance						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'						
						
  -- Copay Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Copay Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||						
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'						
						
  -- Deductible then Copay						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment per visit after Deductible.'		

  -- Sliding Cost Share					
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Specialist'						
    AND BenefitService.value:CostShareType::string = 'Sliding Cost Share'						
  THEN 'First visit Covered at 100%; you pay $0. Then, you pay $50 Copayment per visit.'		
ELSE NULL					
END) AS C_632_Specialist_office_visit_IN,						
						
MAX(CASE						
  -- Not Covered						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'Not Covered'						
  THEN 'Not Covered.'						
						
  -- Coinsurance Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'						
						
  -- Deductible Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'Deductible Only'						
  THEN 'You pay $0 After Deductible.'						
						
  -- No Cost						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'No Cost'						
  THEN 'Covered at 100%; you pay $0.'						
						
  -- Deductible then Coinsurance						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'						
						
  -- Copay Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'Copay Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||						
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'						
						
  -- Deductible then Copay						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Emergency Department'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'						
ELSE 'Not Applicable.'						
END) AS C_617_Emergency_care_coverage_IN,						
						
MAX(CASE
  -- Not Covered                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'Not Covered'                        
  THEN 'Not Covered.'                        
                        
  -- Coinsurance Only                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'                        
                        
  -- Deductible Only                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'Deductible Only'                        
  THEN 'You pay $0 After Deductible.'                        
                        
  -- No Cost                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'No Cost'                        
  THEN 'Covered at 100%; you pay $0.'                        
                        
  -- Deductible then Coinsurance                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'                        
                        
  -- Copay Only                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'Copay Only'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||                        
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'                        
                        
  -- Deductible then Copay                        
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'                        
    AND BenefitService.value:NetworkTier::string = 'INN'                        
    AND BenefitService.value:CostShareGroup::string = 'PCP'                        
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'                        
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'        

  -- Sliding Cost Share    
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
    AND BenefitService.value:NetworkTier::string = 'INN'
    AND BenefitService.value:CostShareGroup::string = 'PCP'
    AND BenefitService.value:CostShareType::string = 'Sliding Cost Share'
  THEN 'First visit Covered at 100%; you pay $0. Then, you pay $20 Copayment per visit.'
    ELSE NULL
END) AS C_631_PCP_Office_Visit_For_Treatment_IN,

MAX(CASE 						
  -- Not Covered						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Not Covered'						
  THEN 'Not Covered.'						
						
  -- Coinsurance Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Coinsurance Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || '.'						
						
  -- Deductible Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Deductible Only'						
  THEN 'You pay $0 After Deductible.'						
						
  -- No Cost						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'No Cost'						
  THEN 'Covered at 100%; you pay $0.'						
						
  -- Deductible then Coinsurance						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.00(%?)$', '\\1') || ' after Deductible.'						
						
  -- Copay Only						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Copay Only'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') ||						
       ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:CopayFrequency), '\.00$', '') || '.'						
						
  -- Deductible then Copay						
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Deductible then Copay'						
  THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Copay), '\.00$', '') || ' Copayment after Deductible.'	

  -- Sliding Cost Share					
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'						
    AND BenefitService.value:NetworkTier::string = 'INN'						
    AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'						
    AND BenefitService.value:CostShareType::string = 'Sliding Cost Share'						
  THEN 'First visit Covered at 100%; you pay $0. Then, you pay $10 Copayment per visit.'
  
ELSE NULL
END) AS C_375_090_IN_Virtual_visit_Primary_care,				
						
									
   '' as Pharmacy_Benefits						
  , 'Please refer to your medical Schedule of Benefits for details.' as "R175#020=Rx_DED_IND"						
,    'Please refer to your medical Schedule of Benefits for details.' as "R175#030=Rx_DED_FAM"						
						
     FROM NETWORK.SIMPLIFY_PLAN_PACKAGE 						
      JOIN TABLE(FLATTEN(input => JSON_DATA:Result.Data.JSON.RxBenefitReview.RxBenefitReviewGrid)) as RxBenefitService						
      JOIN TABLE(FLATTEN(input => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.BenefitReview.BenefitReviewGrid)) AS BenefitService 						
    						
 LEFT OUTER JOIN (SELECT 						
 JSON_DATA:"Result":"Data":FormInstanceID as FormInstanceID						
 ,RxBenefitService.value:RxTierType::String as RxTierType						
 						
 --select *						
FROM NETWORK.SIMPLIFY_PLAN_PACKAGE					
 INNER JOIN network.simplify_plan_package_current_row_vw as cr						
ON SIMPLIFY_PLAN_PACKAGE.simplify_plan_package_key = cr.simplify_plan_package_key						
 ,TABLE(FLATTEN(input => JSON_DATA:Result.Data.JSON.RxBenefitReview.RxBenefitReviewGrid)) as RxBenefitService						
WHERE 1=1 						
 AND RxBenefitService.value:RxTierType =' Retail' --limit 10						
 AND RxBenefitService.value:RxTier = 'Preferred Generic Medications'						
 AND RxBenefitService.value:NetworkTier ='INN'						
 						
 ) copay_amount --limit 10						
ON copay_amount.FormInstanceID = FormInstanceID						
WHERE 1=1 						
AND BenefitService.value:BenefitServiceCode in('BEN019','BEN021','BEN022','BEN023','BEN024','BEN038','BEN062','BEN080','BEN057')						
						
 						
    GROUP BY						
      pk_Master_Plan_ID											
    , SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID			
      ,pk_Ben_Yr						
      ,Update_User						
      ,pk_HIOSPlanID
      ,pk_VarianceID
      ,pk_VariantID						
      ,pk_Network_ID						
      ,Market						
      ,QHP_ID						
      ,QHPID1																		
)						
						
						
,						
DED_LATERAL AS (						
SELECT   												
  MD5(CONCAT(						
        SUBSTRING(sp.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 						
        sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 						
        sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 						
        sp.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
      ))                                               AS dedlat_Master_Plan_ID, 						
  sp.INSERT_DATETIME                                  AS dedlat_Update_Dt,						
  'Snowflake'                                         AS Update_User,						
  SUBSTRING(sp.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4)						
                                                      AS Ben_Yr,						
  MAX(CASE sp.JSON_DATA:Result.Data.JSON.ProductRules:PlanInformation.MarketSegment::String						
        WHEN 'Small Group' THEN 'SG'						
        WHEN 'Individual'  THEN 'IND'						
        WHEN 'Large Group' THEN 'LG'						
      END)                                            AS Market,						
  sp.JSON_DATA:Result.Data.FormInstanceID             AS dedlat_FormInstanceID,						
											
  d.VALUE:CoverageName::string                        AS dedlat_CoverageName, 						
  d.VALUE:NetworkTier::string                         AS dedlat_NetworkTier,  						
  d.VALUE:DeductibleAmount::string                    AS dedlat_DeductibleAmount, 						
											
  MAX(CASE 						
        WHEN UPPER(TRIM(d.VALUE:CoverageName::string)) LIKE 'INDIVIDUAL%' 						
         AND UPPER(TRIM(d.VALUE:NetworkTier::string)) = 'INN'						
          THEN 'C_601_Annual_Deductible_Individual_IN'						
        WHEN UPPER(TRIM(d.VALUE:CoverageName::string)) LIKE 'FAMILY%'						
         AND UPPER(TRIM(d.VALUE:NetworkTier::string)) = 'INN'						
          THEN 'C_602_Annual_Deductible_Family_IN'						
      END)                                            AS dedlat_Column						
FROM NETWORK.SIMPLIFY_PLAN_PACKAGE sp						
JOIN LATERAL FLATTEN(						
       INPUT => sp.JSON_DATA:Result.Data.JSON.GeneralCostShare,						
       PATH  => 'Deductible:DeductibleList'						
     ) AS d						
					
INNER JOIN Benepre pk						
  ON pk.pk_Master_Plan_ID = MD5(CONCAT(						
       SUBSTRING(sp.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 						
       sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 						
       sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 						
       sp.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
     ))						
 AND pk.pk_Update_Dt      = sp.INSERT_DATETIME						
 AND pk.pk_FormInstanceID = sp.JSON_DATA:Result.Data.FormInstanceID						
												
WHERE UPPER(TRIM(d.VALUE:NetworkTier::string)) = 'INN'						
						
GROUP BY 						
  dedlat_Master_Plan_ID,						
  dedlat_Update_Dt,						
  Update_User,						
  Ben_Yr,						
  dedlat_FormInstanceID,						
  dedlat_CoverageName, 						
  dedlat_NetworkTier,  						
  dedlat_DeductibleAmount						
)						
						
 ,						
DED_PIVOT AS (												
  WITH base AS (						
    SELECT						
      dedlat_Master_Plan_ID,						
      dedlat_Update_Dt,						
      dedlat_FormInstanceID,											
      MAX(CASE						
            WHEN UPPER(TRIM(dedlat_NetworkTier)) = 'INN'						
             AND UPPER(TRIM(dedlat_CoverageName)) LIKE 'INDIVIDUAL%'						
              THEN dedlat_DeductibleAmount						
          END) AS C_601_Annual_Deductible_Individual_IN,						
      MAX(CASE						
            WHEN UPPER(TRIM(dedlat_NetworkTier)) = 'INN'						
             AND UPPER(TRIM(dedlat_CoverageName)) LIKE 'FAMILY%'						
              THEN dedlat_DeductibleAmount						
          END) AS C_602_Annual_Deductible_Family_IN						
    FROM DED_LATERAL						
    GROUP BY						
      dedlat_Master_Plan_ID,						
      dedlat_Update_Dt,						
      dedlat_FormInstanceID						
  )												
  , ranked AS (						
    SELECT						
      b.*,						
      ROW_NUMBER() OVER (						
        PARTITION BY dedlat_Master_Plan_ID						
        ORDER BY						
          (CASE WHEN C_601_Annual_Deductible_Individual_IN IS NOT NULL THEN 1 ELSE 0 END						
         + CASE WHEN C_602_Annual_Deductible_Family_IN     IS NOT NULL THEN 1 ELSE 0 END) DESC,						
          dedlat_Update_Dt DESC,						
          dedlat_FormInstanceID DESC						
      ) AS rn						
    FROM base b						
  )						
  SELECT						
    dedlat_Master_Plan_ID AS dedpiv_Master_Plan_ID,						
    dedlat_Update_Dt      AS dedpiv_Update_Dt,						
    dedlat_FormInstanceID AS dedpiv_FormInstanceID,						
    C_601_Annual_Deductible_Individual_IN  AS dedpiv_C_601_Annual_Deductible_Individual_IN,						
    C_602_Annual_Deductible_Family_IN      AS dedpiv_C_602_Annual_Deductible_Family_IN						
  FROM ranked						
  WHERE rn = 1						
)						
						
,						
OOPM_LATERAL AS (						
SELECT 						
  MD5(CONCAT(SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
            )						
     ) AS oopmlat_Master_Plan_ID						
     , 'Snowflake' AS Update_User						
    ,SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4) AS Ben_Yr						
 --						
  ,INSERT_DATETIME AS oopmlat_Update_Dt,						
  SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY,						
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID AS oopmlat_FormInstanceID,  						
  OOPM.VALUE:CoverageName::string AS oopmlat_CoverageName, 						
  OOPM.VALUE:NetworkTier::string AS oopmlat_NetworkTier,  						
  OOPM.VALUE:OOPMAmount::string AS oopmlat_OOPMAmount,						
  CASE CONCAT(OOPM.VALUE:CoverageName::string, OOPM.VALUE:NetworkTier::string) 						
    WHEN 'IndividualINN' THEN 'C_603_Annual_out_of_pocket_limit_Individual_IN' 						
    WHEN 'FamilyINN' THEN 'C_604_Annual_out_of_pocket_limit2_Family_IN'						
  END AS oopmlat_Column						
  FROM NETWORK.SIMPLIFY_PLAN_PACKAGE						
  join  LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.GeneralCostShare, PATH => 'OutofPocketMaximum:OutofPocketMaximumList') OOPM						
  INNER JOIN Benepre PK ON PK.pk_Master_Plan_ID = oopmlat_Master_Plan_ID 						
  AND PK.pk_Update_Dt = oopmlat_Update_Dt 						
  AND PK.pk_FormInstanceID = oopmlat_FormInstanceID						
WHERE oopmlat_NetworkTier = 'INN'						
)						
						
,						
						
OOPM_PIVOT AS (						
SELECT oopmlat_Master_Plan_ID AS oopmpiv_Master_Plan_ID, MAX(oopmlat_Update_Dt) AS oopmpiv_Update_Dt, MAX(oopmlat_FormInstanceID) AS oopmpiv_FormInstanceID,						
  MAX(C_603_Annual_out_of_pocket_limit_Individual_IN) AS oopmpiv_C_603_Annual_out_of_pocket_limit_Individual_IN, 						
  MAX(C_604_Annual_out_of_pocket_limit2_Family_IN) AS oopmpiv_C_604_Annual_out_of_pocket_limit2_Family_IN						
  ,Ben_Yr						
FROM (						
SELECT oopmlat_Master_Plan_ID, oopmlat_Update_Dt, oopmlat_FormInstanceID, "'C_603_Annual_out_of_pocket_limit_Individual_IN'" AS C_603_Annual_out_of_pocket_limit_Individual_IN, 						
  "'C_604_Annual_out_of_pocket_limit2_Family_IN'" AS C_604_Annual_out_of_pocket_limit2_Family_IN, ben_yr						
FROM OOPM_LATERAL						
  PIVOT(MAX(oopmlat_OOPMAmount) FOR oopmlat_Column IN ('C_603_Annual_out_of_pocket_limit_Individual_IN','C_604_Annual_out_of_pocket_limit2_Family_IN')) AS PIV						
) OOPM_AGG						
GROUP BY oopmlat_Master_Plan_ID, ben_yr						
)						
						
						
						
,						
COINS_LATERAL AS (						
  SELECT						
    s.coinlat_Master_Plan_ID,						
    s.coinlat_Update_Dt,						
    s.coinlat_FormInstanceID,						
    s.coinlat_NetworkTier,												
    CASE						
      WHEN s.coins_amt_num > 0						
       AND s.ded_any_num >= 0						
       AND s.coinlat_NetworkTier = 'INN'						
        THEN 'You pay ' ||						
             REGEXP_REPLACE(TO_CHAR(s.coins_amt_raw), '\.?00$*', '') ||	'.'					
             --' after Deductible.'						
      WHEN s.coins_amt_num = 0						
       AND s.ded_any_num > 0						
       AND s.coinlat_NetworkTier = 'INN'						
        THEN 'You pay $0 After Deductible.'						
      WHEN s.coins_amt_num = 0						
       AND s.ded_any_num = 0						
       AND s.coinlat_NetworkTier = 'INN'						
        THEN 'Covered at 100%; you pay $0.'						
    END AS coinlat_C_607_Plan_payment_level_IN,						
												
    REGEXP_REPLACE(TO_CHAR(s.dedpiv_C_601_Annual_Deductible_Individual_IN), '\.00$', '') AS C_601_Annual_Deductible_Individual_IN,						
    REGEXP_REPLACE(REGEXP_REPLACE(s.dedpiv_C_601_Annual_Deductible_Individual_IN, '[^0-9.]*'), '\.00$', '') AS C_601_INTEGER_AnnualDed_IND,						
    REGEXP_REPLACE(TO_CHAR(s.dedpiv_C_602_Annual_Deductible_Family_IN), '\.00$', '') AS C_602_Annual_Deductible_Family_IN,						
    REGEXP_REPLACE(REGEXP_REPLACE(s.dedpiv_C_602_Annual_Deductible_Family_IN, '[^0-9.]*'), '\.00$', '') AS C_602_INTEGER_AnnualDed_FAM,						
    REGEXP_REPLACE(TO_CHAR(s.oopmpiv_C_603_Annual_out_of_pocket_limit_Individual_IN), '\.00$', '') AS C_603_Annual_out_of_pocket_limit_Individual_IN,						
    REGEXP_REPLACE(REGEXP_REPLACE(s.oopmpiv_C_603_Annual_out_of_pocket_limit_Individual_IN, '[^0-9.]*'), '\.00$', '') AS C_603_INTEGER_Annual_out_of_pocket_limit_Individual_IN,						
    REGEXP_REPLACE(TO_CHAR(s.oopmpiv_C_604_Annual_out_of_pocket_limit2_Family_IN), '\.00$', '') AS C_604_Annual_out_of_pocket_limit2_Family_IN,						
    REGEXP_REPLACE(REGEXP_REPLACE(s.oopmpiv_C_604_Annual_out_of_pocket_limit2_Family_IN, '[^0-9.]*'), '\.00$', '') AS C_604_INTEGER_Annual_out_of_pocket_limit2_Family_IN,						
												
    REGEXP_REPLACE(REGEXP_REPLACE(TO_CHAR(s.coins_amt_raw), '[^0-9.]*'), '\.00$', '') AS coinlat_C_607_INTEGER_PlanPaymentLevel_IN						
  FROM (						
    SELECT 											
      MD5(CONCAT(						
        SUBSTRING(sp.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4),						
        sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String,						
        sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String,						
        sp.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
      )) AS coinlat_Master_Plan_ID,						
      sp.INSERT_DATETIME AS coinlat_Update_Dt,						
      sp.JSON_DATA:Result.Data.FormInstanceID AS coinlat_FormInstanceID,						
      COINS.VALUE:NetworkTier::String AS coinlat_NetworkTier,						
											
      COINS.VALUE:CoinsuranceAmount AS coins_amt_raw,						
      dp.dedpiv_C_601_Annual_Deductible_Individual_IN,						
      dp.dedpiv_C_602_Annual_Deductible_Family_IN,						
      o.oopmpiv_C_603_Annual_out_of_pocket_limit_Individual_IN,						
      o.oopmpiv_C_604_Annual_out_of_pocket_limit2_Family_IN,						
											
      TRY_TO_NUMBER(REGEXP_REPLACE(COINS.VALUE:CoinsuranceAmount::String, '[^0-9.]+', '')) AS coins_amt_num,						
      COALESCE(						
        TRY_TO_NUMBER(REGEXP_REPLACE(dp.dedpiv_C_601_Annual_Deductible_Individual_IN::string, '[^0-9.]+', '')),						
        TRY_TO_NUMBER(REGEXP_REPLACE(dp.dedpiv_C_602_Annual_Deductible_Family_IN::string,     '[^0-9.]+', ''))						
      ) AS ded_any_num						
						
    FROM NETWORK.SIMPLIFY_PLAN_PACKAGE sp						
    JOIN LATERAL FLATTEN(						
           INPUT => sp.JSON_DATA:Result.Data.JSON.GeneralCostShare,						
           PATH  => 'Coinsurance:CoinsuranceList'						
         ) COINS						
    INNER JOIN Benepre pk						
      ON pk.pk_Master_Plan_ID  = MD5(CONCAT(						
           SUBSTRING(sp.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4),						
           sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String,						
           sp.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String,						
           sp.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
         ))						
     AND pk.pk_Update_Dt       = sp.INSERT_DATETIME						
     AND pk.pk_FormInstanceID  = sp.JSON_DATA:Result.Data.FormInstanceID						
    LEFT JOIN DED_PIVOT dp						
      ON dp.dedpiv_Master_Plan_ID  = pk.pk_Master_Plan_ID						
     AND dp.dedpiv_Update_Dt       = pk.pk_Update_Dt						
     AND dp.dedpiv_FormInstanceID  = pk.pk_FormInstanceID						
    LEFT JOIN OOPM_PIVOT o						
      ON o.oopmpiv_Master_Plan_ID  = pk.pk_Master_Plan_ID						
						
    WHERE COINS.VALUE:NetworkTier::String = 'INN'						
  ) s						
)						
						
,						
						
BENS_LATERAL AS (						
SELECT DISTINCT						
  MD5(CONCAT(SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 						
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String						
            )						
     ) AS benlat_Master_Plan_ID, 						
 INSERT_DATETIME AS benlat_Update_Dt,						
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID AS benlat_FormInstanceID, 						
  BENS.VALUE:NetworkTier::String AS benlat_NetworkTier,						
  BENS.VALUE:BenefitServiceCode::String AS bens_bsc, 						
  BENS.VALUE:CostShareGroup::String AS bens_csg, 						
  BENS.VALUE:CostShareType::String AS bens_cst,						
  COST.VALUE:CostShareGroup::String AS cost_csg, 						
  COST.VALUE:CostShareType::String AS cost_cst,						
  COST.VALUE:CopayValue::String AS cost_cv, 						
  CASE 						
    -- C_617_Emergency_care_coverage_IN						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'						
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 						
    -- Virtual_Visit_Level_4_IN						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 						
    -- C_375_090_IN_Virtual_visit_Primary_care						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - PCP'						
      AND BENS.VALUE:CostShareType::String = 'Sliding Cost Share'						
    THEN 'First visit Covered at 100%; you pay $0. Then, you pay $10 Copayment per visit.'
    -- Virtual_Visit_Level_1_e_g_specialist						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 	
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Sliding Cost Share'						
    THEN 'First visit Covered at 100%; you pay $0. Then, you pay $25 Copayment per visit.'
    -- C_633_eVisit_IN						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024'						
      AND BENS.VALUE:CostShareGroup::String = 'Virtual Visits - AnywhereCare'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 						
    -- C_654_Inpatient_IN --Inpatient Medical Care Visits						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038'						
      AND BENS.VALUE:CostShareGroup::String = 'Hospital Inpatient'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 						
   -- Behavior_Health_Office_Visit_IN						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057'						
      AND BENS.VALUE:CostShareGroup::String = 'Behavior Health - Office Visit'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.'						
    -- C_631_PCP_office_visit_for_treatment_IN						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Sliding Cost Share'						
    THEN 'First visit Covered at 100%; you pay $0. Then, you pay $20 Copayment per visit.' 
    -- C_632_Specialist_office_visit_IN						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'PCP'						
      AND BENS.VALUE:CostShareType::String = 'Not Covered'						
    THEN 'Not Covered.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || '.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Deductible Only'						
    THEN 'You pay $0 After Deductible.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'Specialist'						
      AND BENS.VALUE:CostShareType::String = 'No Cost'						
    THEN 'Covered at 100%; you pay $0.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Coinsurance'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(COST.VALUE:CopayValue),'\.00$','') || ' after Deductible.' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Copay Only'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment ' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:CopayFrequency),'\.00$','') || '.'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080'						
      AND BENS.VALUE:CostShareGroup::String = 'Specialist'						
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'						
    THEN 'You pay' || REGEXP_REPLACE(TO_CHAR(BENS.VALUE:Copay),'\.00$','') || ' Copayment after Deductible.' 						
  END AS benlat_copayDescription, 						
  CASE  						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019' THEN 'benlat_C_617_Emergency_care_coverage_IN' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021' THEN 'benlat_Virtual_Visit_Level_4_IN'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022' THEN 'benlat_C_375_090_IN_Virtual_visit_Primary_care'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023' THEN 'benlat_Virtual_Visit_Level_1_e_g_specialist'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024' THEN 'benlat_C_633_eVisit_IN'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038' THEN 'benlat_C_654_Inpatient_IN' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062' THEN 'benlat_C_631_PCP_office_visit_for_treatment_IN' 						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057' THEN 'benlat_C_Behavior_Health_Office_Visit_IN'						
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080' THEN 'benlat_C_632_Specialist_office_visit_IN'  						
  END AS benlatColumn						
  
--added this to match BENEFITS_OUT NEW DDL						
FROM NETWORK.SIMPLIFY_PLAN_PACKAGE, 						
   LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.BenefitReview, PATH => 'BenefitReviewGrid') BENS, 						
   LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.CascadingCostShare, PATH => 'CostShareGroup:CostShareGroupList') COST						
						
WHERE benlat_NetworkTier like '%INN%'						
  AND BENS.VALUE:CostShareGroup::String = COST.VALUE:CostShareGroup::String						
  AND BENS.VALUE:CostShareType::String = COST.VALUE:CostShareType::String						
  and BENS.VALUE:NetworkTier::String = 'INN'						
  AND BENS.VALUE:BenefitServiceCode::String IN ('BEN019','BEN021','BEN022','BEN023','BEN024','BEN038','BEN062','BEN080','BEN057')						
  						
						
)						
						
,						
						
BENS_PIVOT AS (						
SELECT benlat_Master_Plan_ID AS benpiv_Master_Plan_ID, MAX(benlat_Update_Dt) AS benpiv_Update_Dt, MAX(benlat_FormInstanceID) AS benpiv_FormInstanceID,						
  MAX(benlat_C_631_PCP_office_visit_for_treatment_IN) AS benpiv_C_631_PCP_office_visit_for_treatment_IN, 						
  MAX(benlat_C_Behavior_Health_Office_Visit_IN) as benpiv_C_Behavior_Health_Office_Visit_IN,						
  MAX(benlat_C_375_090_IN_Virtual_visit_Primary_care) AS benpiv_C_375_090_IN_Virtual_visit_Primary_care, 						
  MAX(benlat_C_633_eVisit_IN) AS benpiv_C_633_eVisit_IN, 						
  MAX(benlat_Virtual_Visit_Level_1_e_g_specialist) AS benpiv_Virtual_Visit_Level_1_e_g_specialist, 						
  MAX(benlat_Virtual_Visit_Level_4_IN) AS benpiv_Virtual_Visit_Level_4_IN, 						
  MAX(benlat_C_632_Specialist_office_visit_IN) AS benpiv_C_632_Specialist_office_visit_IN, 						
  MAX(benlat_C_617_Emergency_care_coverage_IN) AS benpiv_C_617_Emergency_care_coverage_IN, 						
  MAX(benlat_C_654_Inpatient_IN) AS benpiv_C_654_Inpatient_IN  						
FROM (						
SELECT benlat_Master_Plan_ID, benlat_Update_Dt, benlat_FormInstanceID, "'benlat_C_631_PCP_office_visit_for_treatment_IN'" AS benlat_C_631_PCP_office_visit_for_treatment_IN, "'benlat_C_Behavior_Health_Office_Visit_IN'" as benlat_C_Behavior_Health_Office_Visit_IN,						
						
  "'benlat_C_375_090_IN_Virtual_visit_Primary_care'" AS benlat_C_375_090_IN_Virtual_visit_Primary_care, "'benlat_C_633_eVisit_IN'" AS benlat_C_633_eVisit_IN, 						
  "'benlat_Virtual_Visit_Level_1_e_g_specialist'" AS benlat_Virtual_Visit_Level_1_e_g_specialist, "'benlat_Virtual_Visit_Level_4_IN'" AS benlat_Virtual_Visit_Level_4_IN, 						
  "'benlat_C_632_Specialist_office_visit_IN'" AS benlat_C_632_Specialist_office_visit_IN, "'benlat_C_617_Emergency_care_coverage_IN'" AS benlat_C_617_Emergency_care_coverage_IN, 						
  "'benlat_C_654_Inpatient_IN'" AS benlat_C_654_Inpatient_IN 						
FROM BENS_LATERAL						
  PIVOT(MAX(benlat_copayDescription) FOR benlatColumn IN ('benlat_C_631_PCP_office_visit_for_treatment_IN','benlat_C_375_090_IN_Virtual_visit_Primary_care',						
    'benlat_C_633_eVisit_IN','benlat_Virtual_Visit_Level_1_e_g_specialist','benlat_Virtual_Visit_Level_4_IN','benlat_C_632_Specialist_office_visit_IN',						
    'benlat_C_617_Emergency_care_coverage_IN','benlat_C_654_Inpatient_IN', 'benlat_C_Behavior_Health_Office_Visit_IN')) AS PIV						
) BENS_AGG						
GROUP BY benlat_Master_Plan_ID						
)						
,						
						
Product_Key as(						
select 						
						
SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY as SIMPLIFY_PLAN_PACKAGE_KEY						
,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID:: number as pk_FormInstanceID						
,(SIMPLIFY_PLAN_PACKAGE.INSERT_DATETIME) AS pk_Update_Dt						
,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection.PackageEffectiveDate:: variant as Package_effective_Date 						
,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.ProductRules.PlanInformation.PlanEffectiveDate:: variant as Plan_effective_Date						
						
,						
CASE WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4) 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanEffectiveDate::String, 7, 4) 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanEffectiveDate::String, 7, 4) 						
  END AS pk_Ben_Yr						
   , CASE 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN '' 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::String 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:PackageName::String 						
  END AS pk_PackageName						
  ,						
   CASE 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN '' 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.DentalProductRules:DentalProductInformation.PlanName::String  						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.VisionProductRules:VisionProductInformation.PlanName::String 						
  END AS pk_PlanName						
  ,CASE 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN ''  						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN ''						
  END AS pk_HIOSPlanID, 						
  CASE						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN ''  						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN ''						
  END AS pk_VariantID, 						
  CASE 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferMedicalProduct::String) = 'TRUE'						
      AND upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferRxProduct::String) = 'TRUE' 						
      THEN SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String 						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferDentalProduct::String) = 'TRUE' 						
      THEN ''  						
    WHEN upper(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:BundledProducts.OfferVisionProduct::String) = 'TRUE' 						
      THEN ''						
  END AS pk_Network_ID						
 						
						
FROM						
NETWORK.SIMPLIFY_PLAN_PACKAGE						
 INNER JOIN						
NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW 						
						
  ON SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY = SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW.SIMPLIFY_PLAN_PACKAGE_KEY						
  WHERE LENGTH(TRIM(pk_Ben_Yr)) > 0 AND TRIM(pk_Ben_Yr) >= DATE_PART(year, CURRENT_DATE())						
   GROUP BY pk_Ben_Yr, pk_PackageName, pk_PlanName, pk_HIOSPlanID, pk_VariantID, pk_Network_ID , SIMPLIFY_PLAN_PACKAGE.insert_datetime, SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY,Package_effective_Date ,SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID,						
   Plan_effective_Date						
  ),

 RankedRows AS (
  SELECT
      v.PK_MASTER_PLAN_ID AS MASTER_PLAN_ID,
      v.PK_UPDATE_DT      AS UPDATE_DT,
      v.PK_FORMINSTANCEID AS FORMINSTANCEID,
      v.UPDATE_USER,
      v.PK_BEN_YR         AS BEN_YR,
      v.pk_VarianceID,
      v.pk_HIOSPlanID,
      v.MARKET,

      d.C_601_Annual_Deductible_Individual_IN,
      d.C_601_INTEGER_AnnualDed_IND,
      d.C_602_Annual_Deductible_Family_IN,
      d.C_602_INTEGER_AnnualDed_FAM,
      d.C_603_Annual_out_of_pocket_limit_Individual_IN,
      d.C_603_INTEGER_Annual_out_of_pocket_limit_Individual_IN,
      d.C_604_Annual_out_of_pocket_limit2_Family_IN,
      d.C_604_INTEGER_Annual_out_of_pocket_limit2_Family_IN,

      'N/A' AS C_605_Health_Incentive_Account_Individual_IN,
      'N/A' AS C_606_Health_Incentive_Account_Family_IN,

      REGEXP_REPLACE(TO_CHAR(d.COINLAT_C_607_PLAN_PAYMENT_LEVEL_IN), '\.00$', '') AS C_607_PLAN_PAYMENT_LEVEL_IN,
      d.coinlat_C_607_INTEGER_PlanPaymentLevel_IN AS C_607_INTEGER_PLANPAYMENTLEVEL_IN,

      CASE 
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN, b.BENPIV_C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN, b.BENPIV_C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN, b.BENPIV_C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN)),'\.00$','')
      END AS C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN,

      CASE 
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE, b.BENPIV_C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE, b.BENPIV_C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE, b.BENPIV_C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE)),'\.00$','')
      END AS C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE,

      CASE 
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.BEHAVIOR_HEALTH_OFFICE_VISIT_IN, b.BENPIV_C_Behavior_Health_Office_Visit_IN)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.BEHAVIOR_HEALTH_OFFICE_VISIT_IN, b.BENPIV_C_Behavior_Health_Office_Visit_IN)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.BEHAVIOR_HEALTH_OFFICE_VISIT_IN, b.BENPIV_C_Behavior_Health_Office_Visit_IN)),'\.00$','')
      END AS BEHAVIOR_HEALTH_OFFICE_VISIT_IN,

      REGEXP_REPLACE(TO_CHAR(b.BENPIV_C_633_EVISIT_IN),'\.00$','') AS C_633_EVISIT_IN,

      CASE    
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.VIRTUAL_VISIT_LEVEL_4_IN, b.BENPIV_Virtual_Visit_Level_4_IN)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.VIRTUAL_VISIT_LEVEL_4_IN, b.BENPIV_Virtual_Visit_Level_4_IN)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.VIRTUAL_VISIT_LEVEL_4_IN, b.BENPIV_Virtual_Visit_Level_4_IN)),'\.00$','')
      END AS VIRTUAL_VISIT_LEVEL_4_IN,

      CASE
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST, b.BENPIV_Virtual_Visit_Level_1_e_g_specialist)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST, b.BENPIV_Virtual_Visit_Level_1_e_g_specialist)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST, b.BENPIV_Virtual_Visit_Level_1_e_g_specialist)),'\.00$','')
      END AS VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST,

      CASE
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_632_SPECIALIST_OFFICE_VISIT_IN, b.BENPIV_C_632_Specialist_office_visit_IN)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_632_SPECIALIST_OFFICE_VISIT_IN, b.BENPIV_C_632_Specialist_office_visit_IN)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_632_SPECIALIST_OFFICE_VISIT_IN, b.BENPIV_C_632_Specialist_office_visit_IN)),'\.00$','')
      END AS C_632_SPECIALIST_OFFICE_VISIT_IN,

      CASE 
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_617_EMERGENCY_CARE_COVERAGE_IN, b.BENPIV_C_617_Emergency_care_coverage_IN)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_617_EMERGENCY_CARE_COVERAGE_IN, b.BENPIV_C_617_Emergency_care_coverage_IN)),'\.00$','') LIKE '%Not Applicable%.'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_617_EMERGENCY_CARE_COVERAGE_IN, b.BENPIV_C_617_Emergency_care_coverage_IN)),'\.00$','')
      END AS C_617_EMERGENCY_CARE_COVERAGE_IN,

      CASE 
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_654_INPATIENT_IN, b.BENPIV_C_654_Inpatient_IN)),'\.00$','') IS NULL 
          THEN 'Covered at 100%; you pay $0.'
        WHEN REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_654_INPATIENT_IN, b.BENPIV_C_654_Inpatient_IN)),'\.00$','') LIKE '%Not Applicable.%'
          THEN 'Covered at 100%; you pay $0.'
        ELSE REGEXP_REPLACE(TO_CHAR(COALESCE(v.C_654_INPATIENT_IN, b.BENPIV_C_654_Inpatient_IN)),'\.00$','')
      END AS C_654_INPATIENT_IN,

      v.RETAIL_GENERIC,
      v.RETAIL_PREFERRED,
      v.RETAIL_NONPREFERRED,
      v.RETAIL_SPECIALTY,
      v.PHARMACY_BENEFITS,
      'Please refer to your medical Schedule of Benefits for details.' AS "R175#020=Rx_DED_IND",
      'Please refer to your medical Schedule of Benefits for details.' AS "R175#030=Rx_DED_FAM",

    /*  ROW_NUMBER() OVER (
        PARTITION BY d.coinlat_Master_Plan_ID
        ORDER BY d.coinlat_Update_Dt DESC, d.coinlat_Master_Plan_ID
      ) AS rn */

      ROW_NUMBER() OVER (
  PARTITION BY coinlat_Master_Plan_ID, Ben_Yr
  ORDER BY coinlat_Update_Dt DESC, coinlat_master_plan_id
) AS rn


  FROM Benepre v
  INNER JOIN COINS_LATERAL d
    ON v.pk_master_plan_id = d.coinlat_Master_Plan_ID
   AND v.pk_Update_Dt      = d.coinlat_Update_Dt
   AND v.pk_FormInstanceID = d.coinlat_FormInstanceID
  LEFT JOIN BENS_PIVOT b
    ON b.benpiv_Master_Plan_ID = d.coinlat_Master_Plan_ID
  WHERE 1 = 1
)

, base AS (
  SELECT
      -- one logical key per plan: HIOS + VarianceID
      CONCAT(
        COALESCE(r.pk_HIOSPlanID, ''),
        COALESCE(r.pk_VarianceID, '')
      ) AS QHP_ID,

      r.UPDATE_DT,
      r.MASTER_PLAN_ID,
      r.FORMINSTANCEID,
      r.UPDATE_USER,
      r.BEN_YR,
      r.PK_HIOSPLANID,
      r.MARKET,
      r.C_601_ANNUAL_DEDUCTIBLE_INDIVIDUAL_IN,
      r.C_601_INTEGER_ANNUALDED_IND,
      r.C_602_ANNUAL_DEDUCTIBLE_FAMILY_IN,
      r.C_602_INTEGER_ANNUALDED_FAM,
      r.C_603_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_IN,
      r.C_603_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_IN,
      r.C_604_ANNUAL_OUT_OF_POCKET_LIMIT2_FAMILY_IN,
      r.C_604_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT2_FAMILY_IN,
      r.C_605_HEALTH_INCENTIVE_ACCOUNT_INDIVIDUAL_IN,
      r.C_606_HEALTH_INCENTIVE_ACCOUNT_FAMILY_IN,
      r.C_607_PLAN_PAYMENT_LEVEL_IN,
      r.C_607_INTEGER_PLANPAYMENTLEVEL_IN,
      r.C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN,
      r.C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE,
      r.BEHAVIOR_HEALTH_OFFICE_VISIT_IN,
      r.C_633_EVISIT_IN,
      r.VIRTUAL_VISIT_LEVEL_4_IN,
      r.VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST,
      r.C_632_SPECIALIST_OFFICE_VISIT_IN,
      r.C_617_EMERGENCY_CARE_COVERAGE_IN,
      r.C_654_INPATIENT_IN,
      r.RETAIL_GENERIC,
      r.RETAIL_PREFERRED,
      r.RETAIL_NONPREFERRED,
      r.RETAIL_SPECIALTY,
      r.PHARMACY_BENEFITS,
      r."R175#020=Rx_DED_IND",
      r."R175#030=Rx_DED_FAM",

      -- NEW: pick the most recent row per QHP_ID + BEN_YR
      ROW_NUMBER() OVER (
        PARTITION BY
            CONCAT(COALESCE(r.pk_HIOSPlanID, ''),
                   COALESCE(r.pk_VarianceID, '')),
            r.BEN_YR
        ORDER BY
            r.UPDATE_DT DESC,
            r.FORMINSTANCEID DESC
      ) AS rn_qhp

  FROM RankedRows r
  WHERE r.rn = 1
    AND TRY_TO_NUMBER(r.FORMINSTANCEID::STRING) NOT IN (1213866, 1238570)
)

SELECT 
    QHP_ID,
    MASTER_PLAN_ID,
    UPDATE_DT,
    FORMINSTANCEID,
    UPDATE_USER,
    BEN_YR,
    PK_HIOSPLANID,
    MARKET,
    C_601_ANNUAL_DEDUCTIBLE_INDIVIDUAL_IN,
    C_601_INTEGER_ANNUALDED_IND,
    C_602_ANNUAL_DEDUCTIBLE_FAMILY_IN,
    C_602_INTEGER_ANNUALDED_FAM,
    C_603_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_IN,
    C_603_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_IN,
    C_604_ANNUAL_OUT_OF_POCKET_LIMIT2_FAMILY_IN,
    C_604_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT2_FAMILY_IN,
    C_605_HEALTH_INCENTIVE_ACCOUNT_INDIVIDUAL_IN,
    C_606_HEALTH_INCENTIVE_ACCOUNT_FAMILY_IN,
    C_607_PLAN_PAYMENT_LEVEL_IN,
    C_607_INTEGER_PLANPAYMENTLEVEL_IN,
    C_631_PCP_OFFICE_VISIT_FOR_TREATMENT_IN,
    C_375_090_IN_VIRTUAL_VISIT_PRIMARY_CARE,
    BEHAVIOR_HEALTH_OFFICE_VISIT_IN,
    C_633_EVISIT_IN,
    VIRTUAL_VISIT_LEVEL_4_IN,
    VIRTUAL_VISIT_LEVEL_1_E_G_SPECIALIST,
    C_632_SPECIALIST_OFFICE_VISIT_IN,
    C_617_EMERGENCY_CARE_COVERAGE_IN,
    C_654_INPATIENT_IN,
    RETAIL_GENERIC,
    RETAIL_PREFERRED,
    RETAIL_NONPREFERRED,
    RETAIL_SPECIALTY,
    PHARMACY_BENEFITS,
    "R175#020=Rx_DED_IND",
    "R175#030=Rx_DED_FAM",
    rn_qhp AS RN
FROM base
WHERE rn_qhp = 1                  -- keep only the top row per QHP_ID + BEN_YR
  AND BEN_YR IN ('2025','2026')   -- only 2025 and 2026
  AND MARKET = 'IND'              -- still limit to IND
  AND EXISTS (
    SELECT 1
    FROM NETWORK.SIMPLIFY_PLAN_PACKAGE sp
    WHERE TRY_TO_NUMBER(sp.JSON_DATA:Result.Data.FormInstanceID::STRING)
          = TRY_TO_NUMBER(base.FORMINSTANCEID::STRING)
  )
ORDER BY
    QHP_ID,
    BEN_YR DESC;