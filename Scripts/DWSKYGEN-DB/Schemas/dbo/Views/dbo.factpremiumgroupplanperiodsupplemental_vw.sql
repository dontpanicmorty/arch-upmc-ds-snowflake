CREATE OR REPLACE VIEW DBO.FactPremiumGroupPlanPeriodSupplemental_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:PremiumGroupSupplementalKey::NUMBER(38, 0) AS PremiumGroupSupplementalKey, 
		$1:PlanPeriodSupplementalValue::VARCHAR AS PlanPeriodSupplementalValue, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPremiumGroupPlanPeriodSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
