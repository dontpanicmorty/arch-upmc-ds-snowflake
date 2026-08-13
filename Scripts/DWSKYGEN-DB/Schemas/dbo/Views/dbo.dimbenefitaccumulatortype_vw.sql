CREATE OR REPLACE VIEW DBO.DimBenefitAccumulatorType_VW
AS 
SELECT 	$1:BenefitAccumulatorTypeKey::NUMBER(38, 0) AS BenefitAccumulatorTypeKey, 
		$1:BENEFIT_ACCUM_TYPE::VARCHAR AS BENEFIT_ACCUM_TYPE, 
		$1:BenefitAccumulatorTypeDescription::VARCHAR AS BenefitAccumulatorTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBenefitAccumulatorType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
