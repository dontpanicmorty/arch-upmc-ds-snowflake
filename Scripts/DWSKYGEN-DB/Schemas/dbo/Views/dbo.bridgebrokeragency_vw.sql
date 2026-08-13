CREATE OR REPLACE VIEW DBO.BridgeBrokerAgency_VW
AS 
SELECT 	$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeBrokerAgency/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
