CREATE OR REPLACE VIEW DBO.FactPreRequisiteCare_VW
AS 
SELECT 	$1:PreReqBenefitPlanKey::NUMBER(38, 0) AS PreReqBenefitPlanKey, 
		$1:CurrentCodeSetKey::NUMBER(38, 0) AS CurrentCodeSetKey, 
		$1:PreReqCodeSetKey::NUMBER(38, 0) AS PreReqCodeSetKey, 
		$1:EditRuleBenefitPlanKey::NUMBER(38, 0) AS EditRuleBenefitPlanKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:EditRuleTypeDescription::VARCHAR AS EditRuleTypeDescription, 
		$1:ExemptionType::VARCHAR AS ExemptionType, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPreRequisiteCare/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
