CREATE OR REPLACE VIEW DBO.DimDocumentType_VW
AS 
SELECT 	$1:DocumentTypeKey::NUMBER(38, 0) AS DocumentTypeKey, 
		$1:DOCUMENT_TYPE::NUMBER(38, 0) AS DOCUMENT_TYPE, 
		$1:DocumentTypeName::VARCHAR AS DocumentTypeName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDocumentType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

