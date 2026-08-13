CREATE OR REPLACE VIEW DBO.FactInvoicedPremiumRates_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:PremiumGroupPremiumTypeKey::NUMBER(38, 0) AS PremiumGroupPremiumTypeKey, 
		$1:DatePremiumGroupBenefitPlan_EffectiveKey::NUMBER(38, 0) AS DatePremiumGroupBenefitPlan_EffectiveKey, 
		$1:DatePremiumGroupBenefitPlan_TerminationKey::NUMBER(38, 0) AS DatePremiumGroupBenefitPlan_TerminationKey, 
		$1:DatePremiumGroupPremiumRate_EffectiveKey::NUMBER(38, 0) AS DatePremiumGroupPremiumRate_EffectiveKey, 
		$1:DatePremiumGroupPremiumRate_TerminationKey::NUMBER(38, 0) AS DatePremiumGroupPremiumRate_TerminationKey, 
		$1:DateCreateKey::NUMBER(38, 0) AS DateCreateKey, 
		$1:DateInactiveKey::NUMBER(38, 0) AS DateInactiveKey, 
		$1:ActiveFlagKey::NUMBER(38, 0) AS ActiveFlagKey, 
		$1:PREMIUM_RATE::NUMBER(19, 4) AS PREMIUM_RATE, 
		$1:EMPLOYEE_PERCENTAGE::REAL AS EMPLOYEE_PERCENTAGE, 
		$1:EMPLOYER_PERCENTAGE::REAL AS EMPLOYER_PERCENTAGE, 
		$1:DEPENDENT_BY_EMPLOYEE_PERCENTAGE::REAL AS DEPENDENT_BY_EMPLOYEE_PERCENTAGE, 
		$1:DEPENDENT_BY_EMPLOYER_PERCENTAGE::REAL AS DEPENDENT_BY_EMPLOYER_PERCENTAGE, 
		--$1:DWH_Hash::VARCHAR AS DWH_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactInvoicedPremiumRates/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
