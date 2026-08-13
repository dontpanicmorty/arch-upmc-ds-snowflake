CREATE OR REPLACE VIEW DBO.FactBrokerLicenses_VW
AS 
SELECT 	$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BrokerLicenseTypeKey::NUMBER(38, 0) AS BrokerLicenseTypeKey, 
		$1:BrokerStatusKey::NUMBER(38, 0) AS BrokerStatusKey, 
		$1:StateKey::NUMBER(38, 0) AS StateKey, 
		$1:DateSentKey::NUMBER(38, 0) AS DateSentKey, 
		$1:DateIssuedKey::NUMBER(38, 0) AS DateIssuedKey, 
		$1:DateExpirationKey::NUMBER(38, 0) AS DateExpirationKey, 
		$1:DateReceivedKey::NUMBER(38, 0) AS DateReceivedKey, 
		$1:LICENSE_NO::VARCHAR AS LICENSE_NO, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBrokerLicenses/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
