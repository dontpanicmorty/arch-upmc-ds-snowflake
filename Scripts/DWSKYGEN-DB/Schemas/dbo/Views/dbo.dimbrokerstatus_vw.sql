CREATE OR REPLACE VIEW DBO.DimBrokerStatus_VW
AS 
SELECT 	$1:BrokerStatusKey::NUMBER(38, 0) AS BrokerStatusKey, 
		$1:BROKER_STATUS::NUMBER(38, 0) AS BROKER_STATUS, 
		$1:BrokerStatusDescription::VARCHAR AS BrokerStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
