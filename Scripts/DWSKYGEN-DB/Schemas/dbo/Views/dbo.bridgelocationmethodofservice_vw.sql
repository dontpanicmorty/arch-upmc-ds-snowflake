CREATE OR REPLACE VIEW DBO.BridgeLocationMethodOfService_VW
AS 
SELECT 	$1:MethodOfServiceKey::NUMBER(38, 0) AS MethodOfServiceKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeLocationMethodOfService/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);