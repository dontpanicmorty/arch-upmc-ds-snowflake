CREATE OR REPLACE VIEW DBO.DimProviderTerminationReason_VW
AS 
SELECT 	$1:ProviderTerminationReasonKey::NUMBER(38, 0) AS ProviderTerminationReasonKey, 
		$1:PROVIDER_TERMINATION_REASON_ID::NUMBER(38, 0) AS PROVIDER_TERMINATION_REASON_ID, 
		$1:ProviderTerminationReasonDescription::VARCHAR AS ProviderTerminationReasonDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProviderTerminationReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
