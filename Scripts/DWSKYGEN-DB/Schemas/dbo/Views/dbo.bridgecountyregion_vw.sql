CREATE OR REPLACE VIEW DBO.BridgeCountyRegion_VW
AS 
SELECT 	$1:CountyRegionKey::NUMBER(38, 0) AS CountyRegionKey, 
		$1:CountyKey::NUMBER(38, 0) AS CountyKey, 
		$1:RegionKey::NUMBER(38, 0) AS RegionKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeCountyRegion/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

