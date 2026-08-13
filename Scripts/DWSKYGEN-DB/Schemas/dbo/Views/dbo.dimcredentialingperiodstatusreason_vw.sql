CREATE OR REPLACE VIEW DBO.DimCredentialingPeriodStatusReason_VW
AS 
SELECT 	$1:CredentialingPeriodStatusReasonKey::NUMBER(38, 0) AS CredentialingPeriodStatusReasonKey, 
		$1:CREDENTIALING_PERIOD_STATUS_REASON_ID::NUMBER(38, 0) AS CREDENTIALING_PERIOD_STATUS_REASON_ID, 
		$1:CredentialingPeriodStatusReasonDescription::VARCHAR AS CredentialingPeriodStatusReasonDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingPeriodStatusReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
