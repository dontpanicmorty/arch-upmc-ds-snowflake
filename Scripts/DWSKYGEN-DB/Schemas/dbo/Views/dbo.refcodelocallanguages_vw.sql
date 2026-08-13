CREATE OR REPLACE VIEW DBO.RefCodeLocalLanguages_VW
AS 
SELECT 	$1:CodeLocalLanguageKey::NUMBER(38, 0) AS CodeLocalLanguageKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:LocalizedLanguageID::NUMBER(38, 0) AS LocalizedLanguageID, 
		$1:LocalizedLanguageDescription::VARCHAR AS LocalizedLanguageDescription, 
		$1:DescriptionLong::VARCHAR AS DescriptionLong, 
		$1:DescriptionShort::VARCHAR AS DescriptionShort, 
		$1:DescriptionSimple::VARCHAR AS DescriptionSimple, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/RefCodeLocalLanguages/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
