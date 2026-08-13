CREATE OR REPLACE VIEW DBO.FactPremiumGroupBenefitPlans_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CheckingAccountKey::NUMBER(38, 0) AS CheckingAccountKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:PremiumGroupBillingCriteriaKey::NUMBER(38, 0) AS PremiumGroupBillingCriteriaKey, 
		$1:PremiumGroupEnrollmentCriteriaKey::NUMBER(38, 0) AS PremiumGroupEnrollmentCriteriaKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:AccumulatorType::NUMBER(38, 0) AS AccumulatorType, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPremiumGroupBenefitPlans/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
