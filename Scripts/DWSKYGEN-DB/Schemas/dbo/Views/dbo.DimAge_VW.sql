CREATE OR REPLACE VIEW DBO.DimAge_VW
AS 
SELECT 	$1:AgeKey::NUMBER(38, 0) AS AgeKey, 
		$1:Age::NUMBER(38, 0) AS Age, 
		$1:AgeCategory::VARCHAR AS AgeCategory, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAge/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
