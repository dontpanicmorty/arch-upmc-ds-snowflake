CREATE OR REPLACE VIEW DBO.DimTransactionStatus_VW
AS 
SELECT 	$1:TransactionStatusKey::NUMBER(38, 0) AS TransactionStatusKey, 
		$1:TRANSACTION_STATUS_ID::NUMBER(38, 0) AS TRANSACTION_STATUS_ID, 
		$1:TransactionStatusDescription::VARCHAR AS TransactionStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimTransactionStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
