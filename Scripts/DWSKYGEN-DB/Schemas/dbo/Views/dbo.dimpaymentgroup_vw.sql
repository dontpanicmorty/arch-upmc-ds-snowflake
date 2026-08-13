CREATE OR REPLACE VIEW DBO.DimPaymentGroup_VW
AS 
SELECT 	$1:PaymentGroupKey::NUMBER(38, 0) AS PaymentGroupKey, 
		$1:PAYMENT_GROUP_ID::NUMBER(38, 0) AS PAYMENT_GROUP_ID, 
		$1:PaymentGroupDescription::VARCHAR AS PaymentGroupDescription, 
		$1:PayAutoAdvanceFlag::BOOLEAN AS PayAutoAdvanceFlag, 
		$1:PayAutoProcessingFlag::BOOLEAN AS PayAutoProcessingFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPaymentGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
