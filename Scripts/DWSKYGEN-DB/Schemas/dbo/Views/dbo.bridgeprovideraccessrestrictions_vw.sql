CREATE OR REPLACE VIEW DBO.BridgeProviderAccessRestrictions_VW
AS 
SELECT 	$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:AccessRestrictionKey::NUMBER(38, 0) AS AccessRestrictionKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeProviderAccessRestrictions/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);