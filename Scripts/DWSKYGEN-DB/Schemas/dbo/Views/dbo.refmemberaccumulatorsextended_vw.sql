CREATE OR REPLACE VIEW DBO.RefMemberAccumulatorsExtended_VW
AS 
SELECT 	$1:BenefitPlanAttributeKey::NUMBER(38, 0) AS BenefitPlanAttributeKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:RolloverBenefitKey::NUMBER(38, 0) AS RolloverBenefitKey, 
		$1:MemberAccumulatorID::NUMBER(38, 0) AS MemberAccumulatorID, 
		$1:MemberAccumulatorDescription::VARCHAR AS MemberAccumulatorDescription, 
		$1:ROLLOVER_BENEFIT_LOG::VARCHAR AS ROLLOVER_BENEFIT_LOG, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/RefMemberAccumulatorsExtended/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
