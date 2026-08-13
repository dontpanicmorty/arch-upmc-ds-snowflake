create or replace view NETWORK.SIMPLIFY_OUTNETWORK_FLATTEN_VW(
	QHP_ID_PLANS,
	MASTER_PLAN_ID,
	UPDATE_DT,
	FORMINSTANCEID,
	UPDATE_USER,
	BEN_YR,
	PK_HIOSPLANID,
	MARKET,
	C_701_ANNUAL_DEDUCTIBLE_INDIVIDUAL_OON,
	C_701_INTEGER_ANNUALDED_IND,
	C_702_ANNUAL_DEDUCTIBLE_FAMILY_OON,
	C_702_INTEGER_ANNUALDED_FAM,
	C_703_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_OON,
	C_703_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_INDIVIDUAL_OON,
	C_704_ANNUAL_OUT_OF_POCKET_LIMIT_FAMILY_OON,
	C_704_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_FAMILY_OON,
	C_605_HEALTH_INCENTIVE_ACCOUNT_INDIVIDUAL_IN,
	C_606_HEALTH_INCENTIVE_ACCOUNT_FAMILY_IN,
	C_707_PLAN_PAYMENT_LEVEL_OON,
	C_731_PCP_OFFICE_VISIT_FOR_TREATMENT_OON,
	C_375_090_OON_VIRTUAL_VISIT_PRIMARY_CARE,
	BEHAVIOR_HEALTH_OFFICE_VISIT_OON,
	C_733_EVISIT_OON,
	VIRTUAL_VISIT_OON_E_G_SPECIALIST,
	VIRTUAL_VISIT_LEVEL_4_OON,
	C_617_EMERGENCY_CARE_COVERAGE_OON,
	C_754_INPATIENT_OON,
	C_732_SPECIALIST_OFFICE_VISIT_OON,
	RETAIL_GENERIC,
	RETAIL_PREFERRED,
	RETAIL_NONPREFERRED,
	RETAIL_SPECIALTY,
	PHARMACY_BENEFITS,
	"R175#020=Rx_DED_IND",
	"R175#030=Rx_DED_FAM",
	RN
) as
WITH
CascCS AS (
  SELECT 
    p.JSON_DATA:Result.Data.FormInstanceID::string                         AS FormInstanceID,
    UPPER(TRIM(f.value:NetworkTier::string))                               AS NetworkTier,
    UPPER(TRIM(f.value:CostShareGroup::string))                            AS CostShareGroup,
    UPPER(TRIM(f.value:CostShareType::string))                             AS CostShareType,
    /* Prefer CoinsuranceAmount, fallback to CopayValue if needed */
    COALESCE(f.value:CoinsuranceAmount::string, f.value:CopayValue::string) AS CascAmount
  FROM NETWORK.SIMPLIFY_PLAN_PACKAGE p,
       LATERAL FLATTEN(
         INPUT => p.JSON_DATA:Result.Data.JSON.CascadingCostShare,
         PATH  => 'CostShareGroup:CostShareGroupList'
       ) f
  WHERE UPPER(TRIM(f.value:NetworkTier::string))    = 'OON'
    AND UPPER(TRIM(f.value:CostShareType::string))  = 'DEDUCTIBLE THEN COINSURANCE'
    AND (
          UPPER(TRIM(f.value:CostShareGroup::string)) = 'EMERGENCY DEPARTMENT'
          OR REGEXP_LIKE(UPPER(TRIM(f.value:CostShareGroup::string)), 'EMERGENCY.*DEPARTMENT')
        )
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY FormInstanceID, NetworkTier, CostShareType
    ORDER BY 1
  ) = 1
),

Benepre AS(
SELECT
  MD5(CONCAT(SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String
            )
     ) AS pk_Master_Plan_ID
     ,
     SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID AS FormInstanceID,
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
  WHEN RxBenefitService.value:NetworkName::string = 'Non-Participating Provider'
      AND RxBenefitService.value:NetworkTier::String = 'OON'
      AND RxBenefitService.value:RxTier::String = 'Preferred Generic Medications'
      AND RxBenefitService.value:RxTierType::String = 'Retail'
      AND RxBenefitService.value:CostShareType::String = 'Not Covered'
      AND RxBenefitService.value:RxCopay::String = 'Not Covered'
    THEN 'Not Covered.' 
    ELSE 'Not Covered.'
END )AS Retail_Generic ,

max(
CASE
  WHEN RxBenefitService.value:NetworkName::string = 'Non-Participating Provider'
      AND RxBenefitService.value:NetworkTier::String = 'OON'
      AND RxBenefitService.value:RxTier::String = 'Preferred Brand Medications'
      AND RxBenefitService.value:RxTierType::String = 'Retail'
      AND RxBenefitService.value:CostShareType::String = 'Not Covered'
      AND RxBenefitService.value:RxCopay::String = 'Not Covered'
    THEN 'Not Covered.' 
    ELSE 'Not Covered.'
END) AS Retail_Preferred
,
max(
CASE
  WHEN RxBenefitService.value:NetworkName::string = 'Non-Participating Provider'
      AND RxBenefitService.value:NetworkTier::String = 'OON'
      AND RxBenefitService.value:RxTier::String = 'Non Preferred Medications - Brand and Generic'
      AND RxBenefitService.value:RxTierType::String = 'Retail'
      AND RxBenefitService.value:CostShareType::String = 'Not Covered'
      AND RxBenefitService.value:RxCopay::String = 'Not Covered'
    THEN 'Not Covered.'
    ELSE 'Not Covered.'
END) AS Retail_NonPreferred


,
MAX(CASE
  WHEN RxBenefitService.value:NetworkName::string = 'Non-Participating Provider'
      AND RxBenefitService.value:NetworkTier::String = 'OON'
      AND RxBenefitService.value:RxTier::String = 'Specialty Medications - Brand and Generic'
      AND RxBenefitService.value:RxTierType::String = 'Retail'
      AND RxBenefitService.value:CostShareType::String = 'Not Covered'
      AND RxBenefitService.value:RxCopay::String = 'Not Covered'
    THEN 'Not Covered.'
    ELSE 'Not Covered.'
END) AS Retail_Specialty

  ,MAX(  CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'


    -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'
    THEN 
    'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN038'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Hospital Inpatient'
      AND BenefitService.value:CostShareType::string = 'Deductible then Copay'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END )AS C_754_Inpatient_OON

  ,MAX(CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
   WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
   WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
   WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'

    -- Case for 'Deductible then Coinsurance'
   WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'
    THEN
'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
   WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
   WHEN BenefitService.value:BenefitServiceCode::string = 'BEN062'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'PCP'
      AND BenefitService.value:CostShareType::string = 'Deductible then Copay'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END) AS C_731_PCP_Office_Visit_For_Treatment_OON



  ,
  MAX(
  CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'
 -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'Deductible then Coinsurance'
    THEN 'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN057'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Behavioral Health - Office Visit'
      AND BenefitService.value:CostShareType::string = 'Deductible then Copay'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END) AS  Behavior_Health_Office_Visit_OON

,
   MAX(CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'

       -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
    THEN 'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN023'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - Specialist'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END) AS Virtual_Visit_OON_e_g_specialist

,MAX(CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'

    -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
    THEN 'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN021'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END )AS Virtual_Visit_Level_4_OON

  ,
  MAX(CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'

    -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
    THEN 'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN080'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Specialist'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END) AS C_732_Specialist_office_visit_OON,

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  MAX(CASE
    -- Case for 'Not Covered'
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
    AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
    AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'Emergency Department'
    AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'Not Covered'
  THEN 'Not Covered.'

  ------------------------------------------------------------------------

    -- Case for 'Coinsurance Only' (robust normalization + NA guard)
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
      AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
      AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'EMERGENCY DEPARTMENT'
      AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'COINSURANCE ONLY'
      AND UPPER(TRIM(COALESCE(
            BenefitService.value:CostShareType.CoinsuranceAmount::string,
            BenefitService.value:Coinsurance::string
          ))) NOT IN ('NOT APPLICABLE','N/A','NA','')
    THEN 'You pay ' ||
         CASE
           -- handle decimals like 0.3 -> 30%
           WHEN REGEXP_LIKE(COALESCE(
                  BenefitService.value:CostShareType.CoinsuranceAmount::string,
                  BenefitService.value:Coinsurance::string
                ), '^\s*0?\.\d+\s*$')
           THEN REGEXP_REPLACE(
                    TO_CHAR(ROUND(
                      TRY_TO_DECIMAL(COALESCE(
                        BenefitService.value:CostShareType.CoinsuranceAmount::string,
                        BenefitService.value:Coinsurance::string
                      )) * 100, 0
                    )),
                    '\.00$', ''
                ) || '%'
           -- otherwise: strip an existing % (if any), strip .00, then append %
           ELSE REGEXP_REPLACE(
                  REGEXP_REPLACE(
                    COALESCE(
                      BenefitService.value:CostShareType.CoinsuranceAmount::string,
                      BenefitService.value:Coinsurance::string
                    ),
                    '\s*%?\s*$', ''       -- remove % if already present
                  ),
                  '\.00$', ''             -- remove trailing .00
                ) || '%'
         END
         || '. Deductible does not apply.'

      --------------------------------------------------------------------------------

    -- If the coinsurance amount is absent or NA-ish, return Not Applicable.
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
      AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
      AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'EMERGENCY DEPARTMENT'
      AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'COINSURANCE ONLY'
      AND (
            COALESCE(
              TRIM(BenefitService.value:CostShareType.CoinsuranceAmount::string),
              TRIM(BenefitService.value:Coinsurance::string)
            ) IS NULL
            OR UPPER(TRIM(COALESCE(
                 BenefitService.value:CostShareType.CoinsuranceAmount::string,
                 BenefitService.value:Coinsurance::string
               ))) IN ('NOT APPLICABLE','N/A','NA','')
          )
    THEN 'Not Applicable.'

    --------------------------------------------------------------------------------------
  
    -- Case for 'Deductible Only'
      WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
        AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
        AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'Emergency Department'
        AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'Deductible Only'
      THEN 'You pay $0 After Deductible.'

    ------------------------------------------------------------------------------------

    -- Case for 'No Cost'
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
    AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
    AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'Emergency Department'
    AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'No Cost'
  THEN 'Covered at 100%; you pay $0.'

  ---------------------------------------------------------------------------------------
  
    -- Case for 'Deductible then Coinsurance'
WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
  AND UPPER(TRIM(BenefitService.value:NetworkTier::string))    = 'OON'
  AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'EMERGENCY DEPARTMENT'
  AND UPPER(TRIM(BenefitService.value:CostShareType::string))  = 'DEDUCTIBLE THEN COINSURANCE'
THEN
  CASE
    WHEN COALESCE(
           NULLIF(IFF(REGEXP_LIKE(TRIM(BenefitService.value:Coinsurance::string),                     '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(BenefitService.value:Coinsurance::string)),                     ''),
           NULLIF(IFF(REGEXP_LIKE(TRIM(BenefitService.value:CostShareType.CoinsuranceAmount::string), '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(BenefitService.value:CostShareType.CoinsuranceAmount::string)), ''),
           NULLIF(IFF(REGEXP_LIKE(TRIM(BenefitService.value:CostShareType.CopayValue::string),        '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(BenefitService.value:CostShareType.CopayValue::string)),        '')
         ) IS NOT NULL
    THEN
      'You pay ' ||
      REGEXP_REPLACE(
        REGEXP_REPLACE(
          COALESCE(
            NULLIF(IFF(REGEXP_LIKE(TRIM(BenefitService.value:Coinsurance::string),                     '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(BenefitService.value:Coinsurance::string)),                     ''),
            NULLIF(IFF(REGEXP_LIKE(TRIM(BenefitService.value:CostShareType.CoinsuranceAmount::string), '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(BenefitService.value:CostShareType.CoinsuranceAmount::string)), ''),
            NULLIF(IFF(REGEXP_LIKE(TRIM(BenefitService.value:CostShareType.CopayValue::string),        '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(BenefitService.value:CostShareType.CopayValue::string)),        '')
          ),
          '\.00%', '%'
        ),
        '\.00$', ''
      )
      || ' after Deductible.'
    WHEN NULLIF(
           IFF(REGEXP_LIKE(TRIM(Casc.CascAmount), '^(not[ _]?applicable|n/?a|na|null|none)$', 'i'), NULL, TRIM(Casc.CascAmount))
         , ''
         ) IS NOT NULL
    THEN
      'You pay ' ||
      REGEXP_REPLACE(
        REGEXP_REPLACE(
          TRIM(Casc.CascAmount),
          '\.00%', '%'
        ),
        '\.00$', ''
      )
      || ' after Deductible.'
    ELSE NULL
  END 

    ------------------------------------------------------------------------------- 

-- Case for 'Copay Only'
WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
  AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
  AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'EMERGENCY DEPARTMENT'
  AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'COPAY ONLY'
THEN
  'You pay $' ||
  REGEXP_REPLACE(
    REGEXP_REPLACE(
      TRIM(BenefitService.value:Copay::string),
      '[^0-9.]', ''          -- remove $, commas, etc.
    ),
    '\.00$', ''              -- strip trailing .00
  ) ||
  ' Copayment ' ||
  TRIM(BenefitService.value:CopayFrequency::string) ||
  '.'

            -------------------------------------------------------------------------------
  
    -- Case for 'Deductible then Copay'
  WHEN BenefitService.value:BenefitServiceCode::string = 'BEN019'
    AND UPPER(TRIM(BenefitService.value:NetworkTier::string)) = 'OON'
    AND UPPER(TRIM(BenefitService.value:CostShareGroup::string)) = 'Emergency Department'
    AND UPPER(TRIM(BenefitService.value:CostShareType::string)) = 'Deductible then Copay'
  THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'

  ELSE NULL
  END) AS C_617_Emergency_care_coverage_OON

  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ,
  MAX( CASE
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'

     -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
    THEN
    'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN022'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - PCP'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END) AS C_375_090_OON_Virtual_visit_Primary_care

  ,
  MAX(CASE
  
    -- Case for 'Not Covered'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
      AND BenefitService.value:CostShareType::string = 'Not Covered'
    THEN 'Not Covered.'

    -- Case for 'Coinsurance Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
      AND BenefitService.value:CostShareType::string = 'Coinsurance Only'
    THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || '.'

    -- Case for 'Deductible Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
      AND BenefitService.value:CostShareType::string = 'Deductible Only'
    THEN 'You pay $0 After Deductible.'

    -- Case for 'No Cost'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
      AND BenefitService.value:CostShareType::string = 'No Cost'
    THEN 'Covered at 100%; you pay $0.'

       -- Case for 'Deductible then Coinsurance'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
    THEN
    'You pay ' || 
REGEXP_REPLACE(TO_CHAR(BenefitService.value:Coinsurance), '\.?00$*', '') || 
' after Deductible.'

    -- Case for 'Copay Only'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
      AND BenefitService.value:CostShareType::string = 'Copay Only'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment ' || BenefitService.value:CopayFrequency::string || '.'

    -- Case for 'Deductible then Copay'
    WHEN BenefitService.value:BenefitServiceCode::string = 'BEN024'
      AND BenefitService.value:NetworkTier::string = 'OON'
      AND BenefitService.value:CostShareGroup::string = 'Virtual Visits - AnywhereCare'
    THEN 'You pay ' || BenefitService.value:Copay::string || ' Copayment after Deductible.'
  ELSE 'Not Applicable.'
  END )AS C_733_eVisit_OON




   ,'' as Pharmacy_Benefits
  , 'Please refer to your medical Schedule of Benefits for details.' as "R175#020=Rx_DED_IND"
,    'Please refer to your medical Schedule of Benefits for details.' as "R175#030=Rx_DED_FAM"

     FROM NETWORK.SIMPLIFY_PLAN_PACKAGE 
      JOIN TABLE(FLATTEN(input => JSON_DATA:Result.Data.JSON.RxBenefitReview.RxBenefitReviewGrid)) as RxBenefitService
      JOIN TABLE(FLATTEN(input => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.BenefitReview.BenefitReviewGrid)) AS BenefitService 

      /* Join to pre-flattened CascCS (safe, non-lateral OUTER semantics) */
      LEFT JOIN CascCS Casc
        ON Casc.FormInstanceID = SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID::string
       AND Casc.NetworkTier   = UPPER(TRIM(BenefitService.value:NetworkTier::string))
       AND Casc.CostShareType = UPPER(TRIM(BenefitService.value:CostShareType::string))
       AND (
             Casc.CostShareGroup = UPPER(TRIM(BenefitService.value:CostShareGroup::string))
             OR REGEXP_LIKE(Casc.CostShareGroup, 'EMERGENCY.*DEPARTMENT')
           )
    
 LEFT OUTER JOIN (SELECT 
 JSON_DATA:"Result":"Data":FormInstanceID as FormInstanceID
 ,RxBenefitService.value:RxTierType::String as RxTierType
FROM NETWORK.SIMPLIFY_PLAN_PACKAGE 
 INNER JOIN network.simplify_plan_package_current_row_vw  cr
ON SIMPLIFY_PLAN_PACKAGE.simplify_plan_package_key = cr.simplify_plan_package_key
 ,TABLE(FLATTEN(input => JSON_DATA:Result.Data.JSON.RxBenefitReview.RxBenefitReviewGrid)) as RxBenefitService
WHERE 1=1 
 AND RxBenefitService.value:RxTierType like' %Retail'
 AND RxBenefitService.value:RxTier = 'Preferred Generic Medications'
 AND RxBenefitService.value:NetworkTier  like '%OON%'
 ) copay_amount
ON copay_amount.FormInstanceID::string = SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID::string
WHERE 1=1 
AND BenefitService.value:BenefitServiceCode in('BEN019','BEN021','BEN022','BEN023','BEN024','BEN038','BEN062','BEN080','BEN057')
GROUP BY
      pk_Master_Plan_ID
    , SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID
    ,pk_Ben_Yr
    ,Update_User
    ,pk_HIOSPlanID
    ,pk_VariantID
    ,pk_VarianceID
    ,pk_Network_ID
    ,Market
)
,
/* original DED_LATERAL alternative removed */
DED_LATERAL AS (
  SELECT   
    MD5(CONCAT(
      SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4),
      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String,
      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String,
      SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String
    ))                                    AS dedlat_Master_Plan_ID, 
    INSERT_DATETIME                        AS dedlat_Update_Dt,
    'Snowflake'                            AS Update_User,
    SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4) AS Ben_Yr,
    SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID AS dedlat_FormInstanceID,  
    DED.VALUE:CoverageName::string         AS dedlat_CoverageName, 
    DED.VALUE:NetworkTier::string          AS dedlat_NetworkTier,  
    DED.VALUE:DeductibleAmount::string     AS dedlat_DeductibleAmount,
    CASE 
      WHEN UPPER(TRIM(DED.VALUE:CoverageName::string)) = 'INDIVIDUAL'
       AND UPPER(TRIM(DED.VALUE:NetworkTier::string))  = 'OON'
        THEN 'C_701_Annual_Deductible_Individual_OON'
      WHEN UPPER(TRIM(DED.VALUE:CoverageName::string)) = 'FAMILY'
       AND UPPER(TRIM(DED.VALUE:NetworkTier::string))  = 'OON'
        THEN 'C_702_Annual_Deductible_Family_OON'
    END                                     AS dedlat_Column
  FROM NETWORK.SIMPLIFY_PLAN_PACKAGE
  JOIN LATERAL FLATTEN(
         INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.GeneralCostShare,
         PATH  => 'Deductible:DeductibleList'
       ) DED
  WHERE UPPER(TRIM(DED.VALUE:NetworkTier::string)) = 'OON'
)
,
DED_PIVOT AS (
  SELECT
    dedlat_Master_Plan_ID  AS dedpiv_Master_Plan_ID,
    dedlat_Update_Dt       AS dedpiv_Update_Dt,
    dedlat_FormInstanceID  AS dedpiv_FormInstanceID,
    PIV."'C_701_Annual_Deductible_Individual_OON'" AS dedpiv_C_701_Annual_Deductible_Individual_OON,
    PIV."'C_702_Annual_Deductible_Family_OON'"     AS dedpiv_C_702_Annual_Deductible_Family_OON
  FROM (
    SELECT
      dedlat_Master_Plan_ID,
      dedlat_Update_Dt,
      dedlat_FormInstanceID,
      dedlat_Column,
      dedlat_DeductibleAmount
    FROM DED_LATERAL
  ) SRC
  PIVOT (
    MAX(dedlat_DeductibleAmount)
    FOR dedlat_Column IN (
      'C_701_Annual_Deductible_Individual_OON',
      'C_702_Annual_Deductible_Family_OON'
    )
  ) PIV
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
  ,INSERT_DATETIME AS oopmlat_Update_Dt,
  SIMPLIFY_PLAN_PACKAGE.SIMPLIFY_PLAN_PACKAGE_KEY,
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID AS oopmlat_FormInstanceID,  
  OOPM.VALUE:CoverageName::string AS oopmlat_CoverageName, 
  OOPM.VALUE:NetworkTier::string AS oopmlat_NetworkTier,  
  OOPM.VALUE:OOPMAmount::string AS oopmlat_OOPMAmount,
  CASE CONCAT(OOPM.VALUE:CoverageName::string, OOPM.VALUE:NetworkTier::string) 
    WHEN 'IndividualOON' THEN 'C_703_Annual_Out_Of_Pocket_Limit_Individual_OON' 
    WHEN 'FamilyOON'     THEN 'C_704_Annual_Out_Of_Pocket_Limit_Family_OON'
  END AS oopmlat_Column
  FROM NETWORK.SIMPLIFY_PLAN_PACKAGE
  JOIN  LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.GeneralCostShare, PATH => 'OutofPocketMaximum:OutofPocketMaximumList') OOPM
  INNER JOIN Benepre PK ON PK.pk_Master_Plan_ID = oopmlat_Master_Plan_ID 
  AND PK.pk_Update_Dt = oopmlat_Update_Dt 
  AND PK.pk_FormInstanceID = oopmlat_FormInstanceID
WHERE oopmlat_NetworkTier = 'OON'
)
,
OOPM_PIVOT AS (
SELECT oopmlat_Master_Plan_ID AS oopmpiv_Master_Plan_ID, MAX(oopmlat_Update_Dt) AS oopmpiv_Update_Dt, MAX(oopmlat_FormInstanceID) AS oopmpiv_FormInstanceID,
  MAX(C_703_Annual_Out_Of_Pocket_Limit_Individual_OON) AS oopmpiv_C_703_Annual_Out_Of_Pocket_Limit_Individual_OON, 
  MAX(C_704_Annual_Out_Of_Pocket_Limit_Family_OON)     AS oopmpiv_C_704_Annual_Out_Of_Pocket_Limit_Family_OON,
  Ben_Yr
FROM (
SELECT oopmlat_Master_Plan_ID, oopmlat_Update_Dt, oopmlat_FormInstanceID, "'C_703_Annual_Out_Of_Pocket_Limit_Individual_OON'" AS C_703_Annual_Out_Of_Pocket_Limit_Individual_OON, 
  "'C_704_Annual_Out_Of_Pocket_Limit_Family_OON'" AS C_704_Annual_Out_Of_Pocket_Limit_Family_OON, ben_yr
FROM OOPM_LATERAL
  PIVOT(MAX(oopmlat_OOPMAmount) FOR oopmlat_Column IN ('C_703_Annual_Out_Of_Pocket_Limit_Individual_OON','C_704_Annual_Out_Of_Pocket_Limit_Family_OON')) AS PIV
) OOPM_AGG
GROUP BY oopmlat_Master_Plan_ID, ben_yr
)
,
COINS_LATERAL AS (
SELECT 
  MD5(CONCAT(SUBSTRING(SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:MedicalProductSelection.EffectiveDate::String, 7, 4), 
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.HIOSPlanID::String, 
             SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.QHPDetails:PlanIdentifiers.CSRVariationType::String, 
            SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.PackageSelection:NetServID::String
            )
     ) AS coinlat_Master_Plan_ID, 
  INSERT_DATETIME AS coinlat_Update_Dt,
  SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.FormInstanceID AS coinlat_FormInstanceID, 
  COINS.VALUE:NetworkTier::String AS coinlat_NetworkTier, 
  CASE 
    WHEN REGEXP_REPLACE(COINS.VALUE:CoinsuranceAmount::String,'[^0-9.]*') > '0.00' 
         AND IFNULL(REGEXP_REPLACE(dedpiv_C_701_Annual_Deductible_Individual_OON,'[^0-9.]*'), REGEXP_REPLACE(dedpiv_C_702_Annual_Deductible_Family_OON,'[^0-9.]*')) >= '0.00'
         AND COINS.VALUE:NetworkTier::String = 'OON'
         THEN 'You pay ' || REGEXP_REPLACE(TO_CHAR(COINS.VALUE:CoinsuranceAmount), '\.?00$*', '') || ' after Deductible.'
    WHEN REGEXP_REPLACE(COINS.VALUE:CoinsuranceAmount::String,'[^0-9.]*') = '0.00' 
         AND IFNULL(REGEXP_REPLACE(dedpiv_C_701_Annual_Deductible_Individual_OON,'[^0-9.]*'), REGEXP_REPLACE(dedpiv_C_702_Annual_Deductible_Family_OON,'[^0-9.]*')) > '0.00'
         AND COINS.VALUE:NetworkTier::String = 'OON'
         THEN 'You pay $0 After Deductible.'
    WHEN REGEXP_REPLACE(COINS.VALUE:CoinsuranceAmount::String,'[^0-9.]*') = '0.00' 
         AND IFNULL(REGEXP_REPLACE(dedpiv_C_701_Annual_Deductible_Individual_OON,'[^0-9.]*'), REGEXP_REPLACE(dedpiv_C_702_Annual_Deductible_Family_OON,'[^0-9.]*')) = '0.00'
         AND COINS.VALUE:NetworkTier::String = 'OON'
         THEN 'Covered at 100%; you pay $0.'
         ELSE 'Not Covered.'
  END AS coinlat_C_607_Plan_payment_level_OON, 
  REGEXP_REPLACE(TO_CHAR(dedpiv_C_701_Annual_Deductible_Individual_OON), '\.00$', '')  AS C_701_Annual_Deductible_Individual_OON, 
  REGEXP_REPLACE(REGEXP_REPLACE(dedpiv_C_701_Annual_Deductible_Individual_OON,'[^0-9.]*'), '\.00$', '') AS C_701_INTEGER_AnnualDed_IND, 
  REGEXP_REPLACE(TO_CHAR(dedpiv_C_702_Annual_Deductible_Family_OON), '\.00$', '') AS C_702_Annual_Deductible_Family_OON, 
  REGEXP_REPLACE(REGEXP_REPLACE(dedpiv_C_702_Annual_Deductible_Family_OON,'[^0-9.]*'), '\.00$', '') AS C_702_INTEGER_AnnualDed_FAM, 
  REGEXP_REPLACE(TO_CHAR(oopmpiv_C_703_Annual_Out_Of_Pocket_Limit_Individual_OON), '\.00$', '') AS C_703_Annual_Out_Of_Pocket_Limit_Individual_OON, 
  REGEXP_REPLACE(REGEXP_REPLACE(oopmpiv_C_703_Annual_Out_Of_Pocket_Limit_Individual_OON,'[^0-9.]*'), '\.00$', '') AS C_703_Integer_Annual_Out_Of_Pocket_Limit_Individual_OON, 
  REGEXP_REPLACE(TO_CHAR(oopmpiv_C_704_Annual_Out_Of_Pocket_Limit_Family_OON), '\.00$', '') AS C_704_Annual_Out_Of_Pocket_Limit_Family_OON, 
  REGEXP_REPLACE(REGEXP_REPLACE(oopmpiv_C_704_Annual_Out_Of_Pocket_Limit_Family_OON,'[^0-9.]*'), '\.00$', '') AS C_704_Integer_Annual_Out_Of_Pocket_Limit_Family_OON, 
  REGEXP_REPLACE(REGEXP_REPLACE(COINS.VALUE:CoinsuranceAmount::String,'[^0-9.]*'), '\.00$', '') AS coinlat_C_607_INTEGER_PlanPaymentLevel_OON
FROM NETWORK.SIMPLIFY_PLAN_PACKAGE 
JOIN  LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.GeneralCostShare, PATH => 'Coinsurance:CoinsuranceList') COINS
INNER JOIN BENEPRE PK ON PK.pk_Master_Plan_ID = coinlat_Master_Plan_ID 
  AND PK.pk_Update_Dt = coinlat_Update_Dt 
  AND PK.pk_FormInstanceID = coinlat_FormInstanceID
LEFT JOIN DED_PIVOT DP ON DP.dedpiv_Master_Plan_ID = coinlat_Master_Plan_ID
  AND DP.dedpiv_Update_Dt = coinlat_Update_Dt 
  AND DP.dedpiv_FormInstanceID = coinlat_FormInstanceID
LEFT JOIN OOPM_PIVOT o  ON o.oopmpiv_Master_Plan_ID = PK.pk_Master_Plan_ID
WHERE coinlat_NetworkTier = 'OON'
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
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'
      AND BENS.VALUE:CostShareType::String = 'Not Covered'
    THEN 'Not Covered.'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'
      AND BENS.VALUE:CostShareType::String = 'Coinsurance Only'
    THEN 'You pay ' || COST.VALUE:CopayValue::String || '.' 
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
    THEN 'You pay ' || COST.VALUE:CopayValue::String || ' after Deductible.'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'
      AND BENS.VALUE:CostShareType::String = 'Copay Only'
    THEN 'You pay ' || BENS.VALUE:Copay::String || ' Copayment ' || BENS.VALUE:CopayFrequency::String || '.'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019'
      AND BENS.VALUE:CostShareGroup::String = 'Emergency Department'
      AND BENS.VALUE:CostShareType::String = 'Deductible then Copay'
    THEN 'You pay ' || BENS.VALUE:Copay::String || ' Copayment after Deductible.' 
    -- other codes omitted for brevity in this comment block
  END AS benlat_copayDescription, 
  CASE  
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN019' THEN 'benlat_C_617_Emergency_care_coverage_OON' 
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN021' THEN 'benlat_Virtual_Visit_Level_4_OON'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN022' THEN 'benlat_C_375_090_OON_Virtual_visit_Primary_care'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN023' THEN 'benlat_Virtual_Visit_OON_e_g_specialist'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN024' THEN 'benlat_C_733_eVisit_OON'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN038' THEN 'benlat_C_754_Inpatient_OON' 
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN062' THEN 'benlat_C_731_PCP_office_visit_for_treatment_OON'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN057' THEN 'benlat_C_Behavior_Health_Office_Visit_IN'
    WHEN BENS.VALUE:BenefitServiceCode::String = 'BEN080' THEN 'benlat_C_732_Specialist_office_visit_OON'
  END AS benlatColumn
FROM NETWORK.SIMPLIFY_PLAN_PACKAGE, 
   LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.BenefitReview, PATH => 'BenefitReviewGrid') BENS, 
   LATERAL FLATTEN(INPUT => SIMPLIFY_PLAN_PACKAGE.JSON_DATA:Result.Data.JSON.CascadingCostShare, PATH => 'CostShareGroup:CostShareGroupList') COST
WHERE benlat_NetworkTier like '%OON%'
  AND BENS.VALUE:CostShareGroup::String = COST.VALUE:CostShareGroup::String
  AND BENS.VALUE:CostShareType::String = COST.VALUE:CostShareType::String
  AND BENS.VALUE:NetworkTier::String = 'OON'
  AND BENS.VALUE:BenefitServiceCode::String IN ('BEN019','BEN021','BEN022','BEN023','BEN024','BEN038','BEN062','BEN080','BEN057')
)
,
BENS_PIVOT AS (
SELECT benlat_Master_Plan_ID AS benpiv_Master_Plan_ID, MAX(benlat_Update_Dt) AS benpiv_Update_Dt, MAX(benlat_FormInstanceID) AS benpiv_FormInstanceID,
  MAX(benlat_C_731_PCP_office_visit_for_treatment_OON) AS benpiv_C_731_PCP_office_visit_for_treatment_OON, 
  MAX(benlat_C_Behavior_Health_Office_Visit_IN)        AS benpiv_C_Behavior_Health_Office_Visit_IN,
  MAX(benlat_C_375_090_OON_Virtual_visit_Primary_care)  AS benpiv_C_375_090_OON_Virtual_visit_Primary_care, 
  MAX(benlat_C_733_eVisit_OON)                          AS benpiv_C_733_eVisit_OON, 
  MAX(benlat_Virtual_Visit_OON_e_g_specialist)          AS benpiv_Virtual_Visit_OON_e_g_specialist, 
  MAX(benlat_Virtual_Visit_Level_4_OON)                 AS benpiv_Virtual_Visit_Level_4_OON, 
  MAX(benlat_C_732_Specialist_office_visit_OON)         AS benpiv_C_732_Specialist_office_visit_OON, 
  MAX(benlat_C_617_Emergency_care_coverage_OON)         AS benpiv_C_617_Emergency_care_coverage_OON, 
  MAX(benlat_C_754_Inpatient_OON)                       AS benpiv_C_754_Inpatient_OON  
FROM (
SELECT benlat_Master_Plan_ID, benlat_Update_Dt, benlat_FormInstanceID, "'benlat_C_731_PCP_office_visit_for_treatment_OON'" AS benlat_C_731_PCP_office_visit_for_treatment_OON, "'benlat_C_Behavior_Health_Office_Visit_IN'" as benlat_C_Behavior_Health_Office_Visit_IN,
  "'benlat_C_375_090_OON_Virtual_visit_Primary_care'" AS benlat_C_375_090_OON_Virtual_visit_Primary_care, "'benlat_C_733_eVisit_OON'" AS benlat_C_733_eVisit_OON, 
  "'benlat_Virtual_Visit_OON_e_g_specialist'"         AS benlat_Virtual_Visit_OON_e_g_specialist, "'benlat_Virtual_Visit_Level_4_OON'" AS benlat_Virtual_Visit_Level_4_OON, 
  "'benlat_C_732_Specialist_office_visit_OON'"        AS benlat_C_732_Specialist_office_visit_OON, "'benlat_C_617_Emergency_care_coverage_OON'" AS benlat_C_617_Emergency_care_coverage_OON, 
  "'benlat_C_754_Inpatient_OON'"                      AS benlat_C_754_Inpatient_OON 
FROM BENS_LATERAL
  PIVOT(MAX(benlat_copayDescription) FOR benlatColumn IN ('benlat_C_731_PCP_office_visit_for_treatment_OON','benlat_C_375_090_OON_Virtual_visit_Primary_care',
    'benlat_C_733_eVisit_OON','benlat_Virtual_Visit_OON_e_g_specialist','benlat_Virtual_Visit_Level_4_OON','benlat_C_732_Specialist_office_visit_OON',
    'benlat_C_617_Emergency_care_coverage_OON','benlat_C_754_Inpatient_OON', 'benlat_C_Behavior_Health_Office_Visit_IN')) AS PIV
) BENS_AGG
GROUP BY benlat_Master_Plan_ID
)
,
RankedRows AS(
SELECT
   v.PK_MASTER_PLAN_ID as MASTER_PLAN_ID
, v.PK_UPDATE_DT AS UPDATE_DT
, v.FORMINSTANCEID
, v.UPDATE_USER
, v.PK_BEN_YR AS BEN_YR
, v.pk_HIOSPlanID
, v.pk_VariantID
, v.pk_VarianceID
, v.MARKET
, CASE when d.C_701_Annual_Deductible_Individual_OON LIKE '%Not Applicable%' THEN 'Not Covered.' ELSE d.C_701_Annual_Deductible_Individual_OON END AS C_701_Annual_Deductible_Individual_OON
, d.C_701_INTEGER_AnnualDed_IND
, CASE when d.C_702_Annual_Deductible_Family_OON LIKE '%Not Applicable%' THEN 'Not Covered.' ELSE d.C_702_Annual_Deductible_Family_OON END AS C_702_Annual_Deductible_Family_OON
, d.C_702_INTEGER_AnnualDed_FAM
, CASE WHEN d.C_703_Annual_out_of_pocket_limit_Individual_OON LIKE '%Not Applicable%' THEN 'Not Covered.' ELSE d.C_703_Annual_out_of_pocket_limit_Individual_OON END AS C_703_Annual_out_of_pocket_limit_Individual_OON
, d.C_703_INTEGER_Annual_out_of_pocket_limit_Individual_OON 
, CASE WHEN d.C_704_Annual_Out_Of_Pocket_Limit_Family_OON  LIKE '%Not Applicable%' THEN 'Not Covered.' ELSE d.C_704_Annual_Out_Of_Pocket_Limit_Family_OON END AS C_704_Annual_Out_Of_Pocket_Limit_Family_OON
, d.C_704_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_FAMILY_OON
,'N/A' AS C_605_Health_Incentive_Account_Individual_IN
,'N/A' AS C_606_Health_Incentive_Account_Family_IN
, REGEXP_REPLACE(TO_CHAR(d.COINLAT_C_607_PLAN_PAYMENT_LEVEL_OON),'\.00$', '') AS C_707_Plan_payment_level_OON

, CASE WHEN COALESCE(v.C_731_PCP_Office_Visit_For_Treatment_OON,b.BENPIV_C_731_PCP_OFFICE_VISIT_FOR_TREATMENT_OON) IS NULL
   THEN 'Covered at 100%; you pay $0.' 
   WHEN COALESCE(v.C_731_PCP_Office_Visit_For_TREATMENT_OON,b.BENPIV_C_731_PCP_OFFICE_VISIT_FOR_TREATMENT_OON) LIKE '%Not Applicable.%'
    THEN 'Covered at 100%; you pay $0.'
    ELSE COALESCE(v.C_731_PCP_Office_Visit_For_Treatment_OON,b.BENPIV_C_731_PCP_OFFICE_VISIT_FOR_TREATMENT_OON)
   END AS C_731_PCP_OFFICE_VISIT_FOR_TREATMENT_OON
      
, CASE WHEN COALESCE(v.C_375_090_OON_Virtual_visit_Primary_care,b.BENPIV_C_375_090_OON_VIRTUAL_VISIT_PRIMARY_CARE) IS NULL
     THEN 'Covered at 100%; you pay $0.'
      WHEN COALESCE(v.C_375_090_OON_Virtual_visit_Primary_care,b.BENPIV_C_375_090_OON_VIRTUAL_VISIT_PRIMARY_CARE) LIKE '%Not Applicable.%'
      THEN 'Covered at 100%; you pay $0.' 
      ELSE COALESCE(v.C_375_090_OON_Virtual_visit_Primary_care,b.BENPIV_C_375_090_OON_VIRTUAL_VISIT_PRIMARY_CARE)
      END AS C_375_090_OON_VIRTUAL_VISIT_PRIMARY_CARE

, CASE WHEN COALESCE(v.Behavior_Health_Office_Visit_OON, benpiv_C_Behavior_Health_Office_Visit_IN) IS NULL 
   THEN 'Covered at 100%; you pay $0.'
   WHEN COALESCE(v.Behavior_Health_Office_Visit_OON, benpiv_C_Behavior_Health_Office_Visit_IN) LIKE '%Not Applicable.%'
   THEN 'Covered at 100%; you pay $0.' 
   ELSE  COALESCE(v.Behavior_Health_Office_Visit_OON, benpiv_C_Behavior_Health_Office_Visit_IN)
END AS Behavior_Health_Office_Visit_OON

, CASE WHEN COALESCE(v.C_733_EVISIT_OON,b.BENPIV_C_733_EVISIT_OON) IS NULL
   THEN 'Covered at 100%; you pay $0.'
   WHEN COALESCE(v.C_733_EVISIT_OON,b.BENPIV_C_733_EVISIT_OON) LIKE '%Not Applicable.%'
   THEN 'Covered at 100%; you pay $0.'
   ELSE COALESCE(v.C_733_EVISIT_OON,b.BENPIV_C_733_EVISIT_OON)
END AS C_733_EVISIT_OON

, CASE WHEN COALESCE(v.Virtual_Visit_OON_e_g_specialist, benpiv_Virtual_Visit_OON_e_g_specialist) IS NULL
   THEN 'Covered at 100%; you pay $0.'
   WHEN COALESCE(v.Virtual_Visit_OON_e_g_specialist, benpiv_Virtual_Visit_OON_e_g_specialist) LIKE  '%Not Applicable.%'
   THEN 'Covered at 100%; you pay $0.'
   ELSE COALESCE(v.Virtual_Visit_OON_e_g_specialist, benpiv_Virtual_Visit_OON_e_g_specialist)
END AS Virtual_Visit_OON_e_g_specialist

, CASE WHEN COALESCE(v.VIRTUAL_VISIT_LEVEL_4_OON, b.BENPIV_Virtual_Visit_Level_4_OON) IS NULL 
   THEN 'Covered at 100%; you pay $0.'
   WHEN COALESCE(v.VIRTUAL_VISIT_LEVEL_4_OON, b.BENPIV_Virtual_Visit_Level_4_OON) LIKE '%Not Applicable.%'
   THEN 'Covered at 100%; you pay $0.'
   ELSE COALESCE(v.VIRTUAL_VISIT_LEVEL_4_OON, b.BENPIV_Virtual_Visit_Level_4_OON)
END AS VIRTUAL_VISIT_LEVEL_4_OON

, CASE
    /* NEW: if Benepre shows Not Applicable for C_617, take the Benpiv value instead */
    WHEN v.C_617_Emergency_care_coverage_OON ILIKE '%Not Applicable.%'
         AND b.BENPIV_C_617_Emergency_care_coverage_OON IS NOT NULL
      THEN REGEXP_REPLACE(TO_CHAR(b.BENPIV_C_617_Emergency_care_coverage_OON), '\.00$','')
    WHEN v.C_617_Emergency_care_coverage_OON IS NULL
      THEN REGEXP_REPLACE(TO_CHAR(b.BENPIV_C_617_Emergency_care_coverage_OON), '\.00$','')
    ELSE REGEXP_REPLACE(TO_CHAR(v.C_617_Emergency_care_coverage_OON), '\.00$','')
  END AS C_617_Emergency_care_coverage_OON

, CASE  WHEN COALESCE(v.C_754_Inpatient_OON,benpiv_C_754_Inpatient_OON) IS NULL 
   THEN 'Covered at 100%; you pay $0.'
   WHEN COALESCE(v.C_754_Inpatient_OON,benpiv_C_754_Inpatient_OON) LIKE '%Not Applicable.%'
   THEN 'Covered at 100%; you pay $0.'
   ELSE COALESCE(v.C_754_Inpatient_OON,benpiv_C_754_Inpatient_OON)
END AS C_754_Inpatient_OON

, CASE 
   WHEN COALESCE(v.C_732_Specialist_office_visit_OON,benpiv_C_732_Specialist_office_visit_OON) IS NULL
   THEN 'Covered at 100%; you pay $0.'
   WHEN COALESCE(v.C_732_Specialist_office_visit_OON,benpiv_C_732_Specialist_office_visit_OON)  LIKE '%Not Applicable.%'
   THEN 'Covered at 100%; you pay $0.'
   ELSE COALESCE(v.C_732_Specialist_office_visit_OON,benpiv_C_732_Specialist_office_visit_OON)
END AS C_732_Specialist_office_visit_OON

, v.RETAIL_GENERIC
, v.RETAIL_PREFERRED
, v.RETAIL_NONPREFERRED
, v.RETAIL_SPECIALTY
, v.PHARMACY_BENEFITS
, 'Please refer to your medical Schedule of Benefits for details.' as "R175#020=Rx_DED_IND"
, 'Please refer to your medical Schedule of Benefits for details.' as "R175#030=Rx_DED_FAM"

, --ROW_NUMBER() OVER (PARTITION BY  coinlat_Master_Plan_ID ORDER BY coinlat_Update_Dt DESC, coinlat_master_plan_id) AS rn

ROW_NUMBER() OVER (
  PARTITION BY COALESCE(coinlat_Master_Plan_ID, v.pk_master_plan_id)
  ORDER BY COALESCE(coinlat_Update_Dt, v.pk_Update_Dt) DESC,
           COALESCE(coinlat_Master_Plan_ID, v.pk_master_plan_id)
) AS rn

FROM 
  BENEPRE  v
  --INNER JOIN COINS_LATERAL d
  LEFT JOIN COINS_LATERAL d
      ON v.pk_master_plan_id = d.coinlat_Master_Plan_ID
     AND v.pk_Update_Dt      = d.coinlat_Update_Dt 
     AND v.pk_FormInstanceID = d.coinlat_FormInstanceID
 LEFT JOIN BENS_Pivot b
  ON b.benpiv_master_plan_id = d.coinlat_Master_Plan_ID

WHERE 1=1 
)
SELECT *
FROM (
    SELECT
        --spf.qhp_id         AS QHP_ID_PLANS,
        COALESCE(
          NULLIF(TRIM(spf.qhp_id), ''),
          CONCAT(COALESCE(r.pk_HIOSPlanID, ''), COALESCE(r.pk_VarianceID, ''))
        ) AS QHP_ID_PLANS,
        --spf.master_plan_id AS MASTER_PLAN_ID_PLANS,
        r.MASTER_PLAN_ID,
        r.UPDATE_DT,
        r.FORMINSTANCEID,
        r.UPDATE_USER,
        r.BEN_YR,
        r.pk_HIOSPlanID,
        r.MARKET,
        r.C_701_Annual_Deductible_Individual_OON,
        r.C_701_INTEGER_AnnualDed_IND,
        r.C_702_Annual_Deductible_Family_OON,
        r.C_702_INTEGER_AnnualDed_FAM,
        r.C_703_Annual_out_of_pocket_limit_Individual_OON,
        r.C_703_INTEGER_Annual_out_of_pocket_limit_Individual_OON,
        r.C_704_Annual_Out_Of_Pocket_Limit_Family_OON,
        r.C_704_INTEGER_ANNUAL_OUT_OF_POCKET_LIMIT_FAMILY_OON,
        r.C_605_Health_Incentive_Account_Individual_IN,
        r.C_606_Health_Incentive_Account_Family_IN,
        r.C_707_Plan_payment_level_OON,
        r.C_731_PCP_OFFICE_VISIT_FOR_TREATMENT_OON,
        r.C_375_090_OON_VIRTUAL_VISIT_PRIMARY_CARE,
        r.Behavior_Health_Office_Visit_OON,
        r.C_733_EVISIT_OON,
        r.Virtual_Visit_OON_e_g_specialist,
        r.VIRTUAL_VISIT_LEVEL_4_OON,
        r.C_617_Emergency_care_coverage_OON,
        r.C_754_Inpatient_OON,
        r.C_732_Specialist_office_visit_OON,
        r.RETAIL_GENERIC,
        r.RETAIL_PREFERRED,
        r.RETAIL_NONPREFERRED,
        r.RETAIL_SPECIALTY,
        r.PHARMACY_BENEFITS,
        r."R175#020=Rx_DED_IND",
        r."R175#030=Rx_DED_FAM",
        /*ROW_NUMBER() OVER (          PARTITION BY COALESCE(spf.qhp_id, r.pk_HIOSPlanID), r.BEN_YR				
          ORDER BY r.UPDATE_DT DESC, r.MASTER_PLAN_ID) AS rn_qhp*/
         ROW_NUMBER() OVER (
  PARTITION BY COALESCE(spf.qhp_id, CONCAT(r.pk_HIOSPlanID, r.pk_VarianceID)), r.BEN_YR
  ORDER BY r.UPDATE_DT DESC, r.MASTER_PLAN_ID
) AS rn_qhp
 
    FROM RankedRows r
    LEFT JOIN NETWORK.SIMPLIFY_PLAN_PACKAGE_FLATTEN_VW spf
        ON spf.master_plan_id = r.MASTER_PLAN_ID
    WHERE r.rn = 1
      AND r.MARKET = 'IND'
      AND r.BEN_YR >= '2025'
)
WHERE rn_qhp = 1
ORDER BY QHP_ID_PLANS;