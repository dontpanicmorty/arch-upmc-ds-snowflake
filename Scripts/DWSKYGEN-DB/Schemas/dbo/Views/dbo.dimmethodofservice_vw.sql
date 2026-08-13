CREATE OR REPLACE VIEW DBO.DimMethodOfService_VW
AS 
SELECT 	$1:MethodOfServiceKey::NUMBER(38, 0) AS MethodOfServiceKey, 
		$1:METHOD_OF_SERVICE::NUMBER(38, 0) AS METHOD_OF_SERVICE, 
		$1:MethodOfServiceDescription::VARCHAR AS MethodOfServiceDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimMethodOfService/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
