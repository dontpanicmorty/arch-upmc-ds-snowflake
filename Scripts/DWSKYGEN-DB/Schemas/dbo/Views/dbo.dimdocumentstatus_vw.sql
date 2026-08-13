CREATE OR REPLACE VIEW DBO.DimDocumentStatus_VW
AS 
SELECT 	$1:DocumentStatusKey::NUMBER(38, 0) AS DocumentStatusKey, 
		$1:DOCUMENT_STATUS::NUMBER(38, 0) AS DOCUMENT_STATUS, 
		$1:DocumentStatusDescription::VARCHAR AS DocumentStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDocumentStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
