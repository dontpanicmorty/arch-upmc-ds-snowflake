CREATE OR REPLACE VIEW DBO.DimPHIAccessType_VW
AS 
SELECT 	$1:PHIAccessTypeKey::NUMBER(38, 0) AS PHIAccessTypeKey, 
		$1:PHI_ACCESS_TYPE::NUMBER(38, 0) AS PHI_ACCESS_TYPE, 
		$1:PHIAccessTypeDescription::VARCHAR AS PHIAccessTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPHIAccessType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);