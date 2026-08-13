CREATE OR REPLACE VIEW DBO.BridgeDeterminationReasonLanguage_VW
AS 
SELECT 	$1:DeterminationReasonLanguageKey::NUMBER(38, 0) AS DeterminationReasonLanguageKey, 
		$1:DeterminationReasonKey::NUMBER(38, 0) AS DeterminationReasonKey, 
		$1:LanguageKey::NUMBER(38, 0) AS LanguageKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeDeterminationReasonLanguage/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
