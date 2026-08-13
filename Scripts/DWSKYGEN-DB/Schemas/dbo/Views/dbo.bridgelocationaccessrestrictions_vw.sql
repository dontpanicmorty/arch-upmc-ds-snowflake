CREATE OR REPLACE VIEW DBO.BridgeLocationAccessRestrictions_VW
AS 
SELECT 	$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:AccessRestrictionKey::NUMBER(38, 0) AS AccessRestrictionKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeLocationAccessRestrictions/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);