CREATE OR REPLACE VIEW DBO.DimDocumentFileType_VW
AS 
SELECT 	$1:DocumentFileTypeKey::NUMBER(38, 0) AS DocumentFileTypeKey, 
		$1:DOCUMENT_FILE_TYPE::NUMBER(38, 0) AS DOCUMENT_FILE_TYPE, 
		$1:DocumentFileTypeName::VARCHAR AS DocumentFileTypeName, 
		$1:FileExtension::VARCHAR AS FileExtension, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDocumentFileType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
