CREATE OR REPLACE VIEW DBO.DimDeterminationReasonLanguage_VW
AS 
SELECT 	$1:DeterminationReasonLanguageKey::NUMBER(38, 0) AS DeterminationReasonLanguageKey, 
		$1:SimpleDescription::VARCHAR AS SimpleDescription, 
		$1:DeterminationReason::VARCHAR AS DeterminationReason, 
		$1:LetterDescription::VARCHAR AS LetterDescription,
		$1:RecordStartDate::DATE AS RecordStartDate,
		$1:RecordEndDate::DATE AS RecordEndDate,
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent,
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime,
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDeterminationReasonLanguage/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
