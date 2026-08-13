CREATE OR REPLACE VIEW DBO.FactBenefitPlanCoinsurance_VW
AS 
SELECT 	$1:BenefitLevelKey::NUMBER(38, 0) AS BenefitLevelKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:DateProductPeriodEffectiveKey::NUMBER(38, 0) AS DateProductPeriodEffectiveKey, 
		$1:DateProductPeriodTerminationKey::NUMBER(38, 0) AS DateProductPeriodTerminationKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:BENEFIT_LEVEL_ESCALATION::NUMBER(38, 0) AS BENEFIT_LEVEL_ESCALATION, 
		$1:COINSURANCE_PERCENT::NUMBER(7, 2) AS COINSURANCE_PERCENT, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBenefitPlanCoinsurance/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
