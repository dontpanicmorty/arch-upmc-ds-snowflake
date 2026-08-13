CREATE OR REPLACE VIEW DBO.FactBenefitServiceLimitations_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateProductPeriodEffectiveKey::NUMBER(38, 0) AS DateProductPeriodEffectiveKey, 
		$1:DateProductPeriodTerminationKey::NUMBER(38, 0) AS DateProductPeriodTerminationKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:DiagnosisCodeSetKey::NUMBER(38, 0) AS DiagnosisCodeSetKey, 
		$1:SpecialtyKey::NUMBER(38, 0) AS SpecialtyKey, 
		$1:SpecialtyGroupKey::NUMBER(38, 0) AS SpecialtyGroupKey, 
		$1:AgeMin::NUMBER(38, 0) AS AgeMin, 
		$1:AgeMax::NUMBER(38, 0) AS AgeMax, 
		$1:RECORD_TYPE::NUMBER(38, 0) AS RECORD_TYPE, 
		$1:ServiceLimitationDescription::VARCHAR AS ServiceLimitationDescription, 
		$1:ServiceLimitationMaximumCount::NUMBER(38, 0) AS ServiceLimitationMaximumCount, 
		$1:ServiceLimitationPeriodLength::NUMBER(38, 0) AS ServiceLimitationPeriodLength, 
		$1:ServiceLimitationPeriodLengthDescription::VARCHAR AS ServiceLimitationPeriodLengthDescription, 
		$1:ServicesPerPeriodCriteriaDescription::VARCHAR AS ServicesPerPeriodCriteriaDescription, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBenefitServiceLimitations/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
