CREATE OR REPLACE VIEW DBO.DimCredentialingPeriodType_VW
AS 
SELECT 	$1:CredentialingPeriodTypeKey::NUMBER(38, 0) AS CredentialingPeriodTypeKey, 
		$1:CREDENTIALING_PERIOD_TYPE::NUMBER(38, 0) AS CREDENTIALING_PERIOD_TYPE, 
		$1:CredentialingPeriodTypeDescription::VARCHAR AS CredentialingPeriodTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingPeriodType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
