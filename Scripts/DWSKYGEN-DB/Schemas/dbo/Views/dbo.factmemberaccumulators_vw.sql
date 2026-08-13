CREATE OR REPLACE VIEW DBO.FactMemberAccumulators_VW
AS 
SELECT 	$1:BenefitPlanAttributeKey::NUMBER(38, 0) AS BenefitPlanAttributeKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:RolloverBenefitKey::NUMBER(38, 0) AS RolloverBenefitKey, 
		$1:AccumulatorTypeDescription::VARCHAR AS AccumulatorTypeDescription, 
		$1:MemberAccumulatorID::NUMBER(38, 0) AS MemberAccumulatorID, 
		$1:MemberAccumulatorDescription::VARCHAR AS MemberAccumulatorDescription, 
		$1:MaximumAmount::NUMBER(19, 4) AS MaximumAmount, 
		$1:DeductibleAmount::NUMBER(19, 4) AS DeductibleAmount, 
		$1:OOP_Amount::NUMBER(19, 4) AS OOP_Amount, 
		$1:MaximumRolloverAmount::NUMBER(19, 4) AS MaximumRolloverAmount, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactMemberAccumulators/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
