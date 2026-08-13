CREATE OR REPLACE VIEW DBO.DimBenefitAccumulatorScope_VW
AS 
SELECT 	$1:BenefitAccumulatorScopeKey::NUMBER(38, 0) AS BenefitAccumulatorScopeKey, 
		$1:BENEFIT_ACCUM_SCOPE::VARCHAR AS BENEFIT_ACCUM_SCOPE, 
		$1:BenefitAccumulatorScopeDescription::VARCHAR AS BenefitAccumulatorScopeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBenefitAccumulatorScope/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
