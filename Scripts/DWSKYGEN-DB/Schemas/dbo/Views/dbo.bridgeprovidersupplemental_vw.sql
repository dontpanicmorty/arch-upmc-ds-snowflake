CREATE OR REPLACE VIEW DBO.BridgeProviderSupplemental_VW
AS 
SELECT 	$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:ProviderSupplementalKey::NUMBER(38, 0) AS ProviderSupplementalKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeProviderSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);