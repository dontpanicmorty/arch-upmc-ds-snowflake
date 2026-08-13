CREATE OR REPLACE VIEW DBO.DimBrokerCommissionPaymentStatus_VW
AS 
SELECT 	$1:BrokerCommissionPaymentStatusKey::NUMBER(38, 0) AS BrokerCommissionPaymentStatusKey, 
		$1:BROKER_COMMISSION_PAYMENT_STATUS::NUMBER(38, 0) AS BROKER_COMMISSION_PAYMENT_STATUS, 
		$1:BrokerCommissionPaymentStatusDescription::VARCHAR AS BrokerCommissionPaymentStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerCommissionPaymentStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
