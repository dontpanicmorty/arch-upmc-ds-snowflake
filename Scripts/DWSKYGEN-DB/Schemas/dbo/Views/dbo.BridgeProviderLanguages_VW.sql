CREATE OR REPLACE VIEW DBO.BridgeProviderLanguages_VW
AS 
SELECT 	$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:LanguageKey::NUMBER(38, 0) AS LanguageKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeProviderLanguages/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);