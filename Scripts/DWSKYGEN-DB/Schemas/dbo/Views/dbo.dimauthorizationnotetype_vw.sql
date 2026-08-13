CREATE OR REPLACE VIEW DBO.DimAuthorizationNoteType_VW
AS 
SELECT 	$1:AuthorizationNoteTypeKey::NUMBER(38, 0) AS AuthorizationNoteTypeKey, 
		$1:NOTE_TYPE::NUMBER(38, 0) AS NOTE_TYPE, 
		$1:NoteTypeDescription::VARCHAR AS NoteTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationNoteType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
