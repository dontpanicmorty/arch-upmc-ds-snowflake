CREATE OR REPLACE VIEW DBO.BridgeLocationPublicTransportationMode_VW
AS 
SELECT 	$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:PublicTransportationModeKey::NUMBER(38, 0) AS PublicTransportationModeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeLocationPublicTransportationMode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);