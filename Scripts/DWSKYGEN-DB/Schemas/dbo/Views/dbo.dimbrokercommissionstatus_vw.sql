CREATE OR REPLACE VIEW DBO.DimBrokerCommissionStatus_VW
AS 
SELECT 	$1:BrokerCommissionStatusKey::NUMBER(38, 0) AS BrokerCommissionStatusKey, 
		$1:BROKER_COMMISSION_STATUS::NUMBER(38, 0) AS BROKER_COMMISSION_STATUS, 
		$1:BrokerCommissionStatusDescription::VARCHAR AS BrokerCommissionStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerCommissionStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
