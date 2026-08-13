CREATE OR REPLACE VIEW DBO.DimRecordSource_VW
AS 
SELECT 	$1:RecordSourceKey::NUMBER(38, 0) AS RecordSourceKey, 
		$1:RECORD_SOURCE_ID::NUMBER(38, 0) AS RECORD_SOURCE_ID, 
		$1:RecordSourceName::VARCHAR AS RecordSourceName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRecordSource/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
