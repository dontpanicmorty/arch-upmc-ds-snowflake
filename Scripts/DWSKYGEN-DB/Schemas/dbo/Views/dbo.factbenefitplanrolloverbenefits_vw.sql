CREATE OR REPLACE VIEW DBO.FactBenefitPlanRolloverBenefits_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BenefitAccumulatorTypeKey::NUMBER(38, 0) AS BenefitAccumulatorTypeKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:RolloverBenefitKey::NUMBER(38, 0) AS RolloverBenefitKey, 
		$1:SubscriberContractTypeKey::NUMBER(38, 0) AS SubscriberContractTypeKey, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBenefitPlanRolloverBenefits/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
