CREATE OR REPLACE VIEW DBO.DimEntityType_VW
AS 
SELECT 	$1:EntityTypeKey::NUMBER(38, 0) AS EntityTypeKey, 
		$1:ENTITY_TYPE::NUMBER(38, 0) AS ENTITY_TYPE, 
		$1:EntityTypeDescription::VARCHAR AS EntityTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimEntityType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
