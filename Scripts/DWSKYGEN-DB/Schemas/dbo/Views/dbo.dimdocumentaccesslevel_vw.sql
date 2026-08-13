CREATE OR REPLACE VIEW DBO.DimDocumentAccessLevel_VW
AS 
SELECT 	$1:DocumentAccessLevelKey::NUMBER(38, 0) AS DocumentAccessLevelKey, 
		$1:DOCUMENT_TYPE_ACCESS_LEVEL::NUMBER(38, 0) AS DOCUMENT_TYPE_ACCESS_LEVEL, 
		$1:DocumentAccessLevelDescription::VARCHAR AS DocumentAccessLevelDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDocumentAccessLevel/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
