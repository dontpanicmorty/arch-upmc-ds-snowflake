CREATE OR REPLACE VIEW DBO.BridgeProviderSimpleSpecialty_VW
AS 
SELECT 	$1:SpecialtyKey::NUMBER(38, 0) AS SpecialtyKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeProviderSimpleSpecialty/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);