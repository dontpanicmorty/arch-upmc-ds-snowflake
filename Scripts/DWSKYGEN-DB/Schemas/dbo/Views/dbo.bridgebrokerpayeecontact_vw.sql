CREATE OR REPLACE VIEW DBO.BridgeBrokerPayeeContact_VW
AS 
SELECT 	$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:BrokerContactKey::NUMBER(38, 0) AS BrokerContactKey, 
		$1:ContactTypeDescription::VARCHAR AS ContactTypeDescription, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeBrokerPayeeContact/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
