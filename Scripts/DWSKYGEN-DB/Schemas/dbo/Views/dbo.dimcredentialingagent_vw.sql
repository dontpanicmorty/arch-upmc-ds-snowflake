CREATE OR REPLACE VIEW DBO.DimCredentialingAgent_VW
AS 
SELECT 	$1:CredentialingAgentKey::NUMBER(38, 0) AS CredentialingAgentKey, 
		$1:CREDENTIALING_AGENT_ID::NUMBER(38, 0) AS CREDENTIALING_AGENT_ID, 
		$1:CredentialingAgentDescription::VARCHAR AS CredentialingAgentDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingAgent/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
