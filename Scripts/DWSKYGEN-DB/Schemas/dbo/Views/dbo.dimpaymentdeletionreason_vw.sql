CREATE OR REPLACE VIEW DBO.DimPaymentDeletionReason_VW
AS 
SELECT 	$1:PaymentDeletionReasonKey::NUMBER(38, 0) AS PaymentDeletionReasonKey, 
		$1:PAYMENT_DELETION_REASON_ID::NUMBER(38, 0) AS PAYMENT_DELETION_REASON_ID, 
		$1:PaymentDeletionReasonDescription::VARCHAR AS PaymentDeletionReasonDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPaymentDeletionReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
