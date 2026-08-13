CREATE OR REPLACE VIEW DBO.DimBenefitPeriodType_VW
AS 
SELECT 	$1:BenefitPeriodTypeKey::NUMBER(38, 0) AS BenefitPeriodTypeKey, 
		$1:BENEFIT_PERIOD_TYPE::VARCHAR AS BENEFIT_PERIOD_TYPE, 
		$1:BenefitPeriodTypeDescription::VARCHAR AS BenefitPeriodTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBenefitPeriodType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
