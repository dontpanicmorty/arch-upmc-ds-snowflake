CREATE OR REPLACE VIEW DBO.BridgeCredentialingAgentNetwork_VW
AS 
SELECT 	$1:CredentialingAgentKey::NUMBER(38, 0) AS CredentialingAgentKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeCredentialingAgentNetwork/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
