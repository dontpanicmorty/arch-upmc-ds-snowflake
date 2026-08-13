CREATE OR REPLACE VIEW DBO.DimBillingType_VW
AS 
SELECT 	$1:BillingTypeKey::NUMBER(38, 0) AS BillingTypeKey, 
		$1:BILLING_TYPE::NUMBER(38, 0) AS BILLING_TYPE, 
		$1:BillingTypeDescription::VARCHAR AS BillingTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBillingType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
