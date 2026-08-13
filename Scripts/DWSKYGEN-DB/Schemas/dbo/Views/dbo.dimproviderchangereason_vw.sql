CREATE OR REPLACE VIEW DBO.DimProviderChangeReason_VW
AS 
SELECT 	$1:ProviderChangeReasonKey::NUMBER(38, 0) AS ProviderChangeReasonKey, 
		$1:PROVIDER_CHANGE_REASON::VARCHAR AS PROVIDER_CHANGE_REASON, 
		$1:ProviderChangeReasonDescription::VARCHAR AS ProviderChangeReasonDescription, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		$1:RecordStartDate::DATE AS RecordStartDate
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProviderChangeReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
