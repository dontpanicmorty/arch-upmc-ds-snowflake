CREATE OR REPLACE VIEW DBO.DimRecordSourceSubType_VW
AS 
SELECT 	$1:RecordSourceSubTypeKey::NUMBER(38, 0) AS RecordSourceSubTypeKey, 
		$1:RECORD_SOURCE_SUBTYPE::NUMBER(38, 0) AS RECORD_SOURCE_SUBTYPE, 
		$1:RecordSourceSubTypeDescription::VARCHAR AS RecordSourceSubTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRecordSourceSubType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
