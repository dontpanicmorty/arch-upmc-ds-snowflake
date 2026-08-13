CREATE OR REPLACE VIEW DBO.DimCredentialingPeriodStatus_VW
AS 
SELECT 	$1:CredentialingPeriodStatusKey::NUMBER(38, 0) AS CredentialingPeriodStatusKey, 
		$1:CREDENTIALING_PERIOD_STATUS::NUMBER(38, 0) AS CREDENTIALING_PERIOD_STATUS, 
		$1:CredentialingPeriodStatusDescription::VARCHAR AS CredentialingPeriodStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingPeriodStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
