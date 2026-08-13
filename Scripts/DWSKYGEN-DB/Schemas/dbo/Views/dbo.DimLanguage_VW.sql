CREATE OR REPLACE VIEW DBO.DimLanguage_VW
AS 
SELECT 	$1:LanguageKey::NUMBER(38, 0) AS LanguageKey, 
		$1:LANGUAGE_ID::NUMBER(38, 0) AS LANGUAGE_ID, 
		$1:LanguageDescription::VARCHAR AS LanguageDescription, 
		$1:ISO_639_2B::VARCHAR AS ISO_639_2B, 
		$1:ISO_639_2T::VARCHAR AS ISO_639_2T, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimLanguage/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
