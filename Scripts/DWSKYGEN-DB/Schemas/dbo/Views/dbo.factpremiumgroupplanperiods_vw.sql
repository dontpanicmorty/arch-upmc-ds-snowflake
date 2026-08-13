CREATE OR REPLACE VIEW DBO.FactPremiumGroupPlanPeriods_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BillingAttributeKey::NUMBER(38, 0) AS BillingAttributeKey, 
		$1:BusinessTypeKey::NUMBER(38, 0) AS BusinessTypeKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:WellnessProgramKey::NUMBER(38, 0) AS WellnessProgramKey, 
		$1:GroupEnrollmentType::VARCHAR AS GroupEnrollmentType, 
		$1:DistributionType::VARCHAR AS DistributionType, 
		$1:DistributionMethod::VARCHAR AS DistributionMethod, 
		$1:ContributionType::VARCHAR AS ContributionType, 
		$1:PLAN_NUMBER::VARCHAR AS PLAN_NUMBER, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPremiumGroupPlanPeriods/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
