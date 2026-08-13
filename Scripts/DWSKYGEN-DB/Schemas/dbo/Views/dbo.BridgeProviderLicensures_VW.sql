CREATE OR REPLACE VIEW DBO.BridgeProviderLicensures_VW
AS 
SELECT 	$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:LicensureKey::NUMBER(38, 0) AS LicensureKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeProviderLicensures/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);