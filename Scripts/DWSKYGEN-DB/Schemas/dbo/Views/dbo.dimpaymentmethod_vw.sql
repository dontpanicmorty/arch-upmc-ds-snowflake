CREATE OR REPLACE VIEW DBO.DimPaymentMethod_VW
AS 
SELECT 	$1:PaymentMethodKey::NUMBER(38, 0) AS PaymentMethodKey, 
		$1:PAYMENT_METHOD::NUMBER(38, 0) AS PAYMENT_METHOD, 
		$1:PaymentMethodDescription::VARCHAR AS PaymentMethodDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPaymentMethod/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
