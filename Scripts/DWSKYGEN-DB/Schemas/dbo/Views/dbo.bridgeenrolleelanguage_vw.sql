CREATE OR REPLACE VIEW DBO.BridgeEnrolleeLanguage_VW
AS 
SELECT 	$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:LanguageKey::NUMBER(38, 0) AS LanguageKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeEnrolleeLanguage/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);