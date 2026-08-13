CREATE OR REPLACE VIEW DBO.DimTransactionType_VW
AS 
SELECT 	$1:TransactionTypeKey::NUMBER(38, 0) AS TransactionTypeKey, 
		$1:TRANSACTION_TYPE::NUMBER(38, 0) AS TRANSACTION_TYPE, 
		$1:TransactionTypeDescription::VARCHAR AS TransactionTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimTransactionType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

