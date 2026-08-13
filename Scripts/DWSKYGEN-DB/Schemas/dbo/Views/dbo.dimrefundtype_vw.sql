CREATE OR REPLACE VIEW DBO.DimRefundType_VW
AS 
SELECT 	$1:RefundTypeKey::NUMBER(38, 0) AS RefundTypeKey, 
		$1:REFUND_TYPE::NUMBER(38, 0) AS REFUND_TYPE, 
		$1:RefundTypeDescription::VARCHAR AS RefundTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRefundType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
