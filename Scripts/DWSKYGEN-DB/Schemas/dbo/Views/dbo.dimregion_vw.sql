CREATE OR REPLACE VIEW DBO.DimRegion_VW
AS 
SELECT 	$1:RegionKey::NUMBER(38, 0) AS RegionKey, 
		$1:REGION_ID::NUMBER(38, 0) AS REGION_ID, 
		$1:RegionName::VARCHAR AS RegionName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRegion/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
