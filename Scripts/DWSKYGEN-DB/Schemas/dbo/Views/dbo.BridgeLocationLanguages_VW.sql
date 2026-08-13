CREATE OR REPLACE VIEW DBO.BridgeLocationLanguages_VW
AS 
SELECT 	$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:LanguageKey::NUMBER(38, 0) AS LanguageKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeLocationLanguages/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);