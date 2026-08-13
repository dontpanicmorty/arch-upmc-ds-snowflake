CREATE OR REPLACE VIEW DBO.DimResolutionType_VW
AS 
SELECT 	$1:ResolutionTypeKey::NUMBER(38, 0) AS ResolutionTypeKey, 
		$1:RESOLUTION_TYPE::NUMBER(38, 0) AS RESOLUTION_TYPE, 
		$1:ResolutionTypeDescription::VARCHAR AS ResolutionTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimResolutionType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
