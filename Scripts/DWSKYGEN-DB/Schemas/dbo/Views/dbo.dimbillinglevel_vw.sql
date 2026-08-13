CREATE OR REPLACE VIEW DBO.DimBillingLevel_VW
AS 
SELECT 	$1:BillingLevelKey::NUMBER(38, 0) AS BillingLevelKey, 
		$1:BILLING_LEVEL::NUMBER(38, 0) AS BILLING_LEVEL, 
		$1:BillingLevelDescription::VARCHAR AS BillingLevelDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBillingLevel/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
