CREATE OR REPLACE VIEW DBO.DimLogType_VW
AS 
SELECT 	$1:LogTypeKey::NUMBER(38, 0) AS LogTypeKey, 
		$1:LOG_TYPE::NUMBER(38, 0) AS LOG_TYPE, 
		$1:LogTypeDescription::VARCHAR AS LogTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimLogType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
