CREATE OR REPLACE VIEW DBO.DimProviderAccessStatus_VW
AS 
SELECT 	$1:ProviderAccessStatusKey::NUMBER(38, 0) AS ProviderAccessStatusKey, 
		$1:PROVIDER_ACCESS_STATUS::NUMBER(38, 0) AS PROVIDER_ACCESS_STATUS, 
		$1:ProviderAccessStatusDescription::VARCHAR AS ProviderAccessStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProviderAccessStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
