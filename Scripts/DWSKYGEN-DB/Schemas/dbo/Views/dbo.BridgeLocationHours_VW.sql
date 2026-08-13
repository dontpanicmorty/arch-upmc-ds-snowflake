CREATE OR REPLACE VIEW DBO.BridgeLocationHours_VW
AS 
SELECT 	$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:LocationHourKey::NUMBER(38, 0) AS LocationHourKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeLocationHours/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);