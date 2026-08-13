CREATE OR REPLACE VIEW DBO.DimVendorPaymentStatuses_VW
AS 
SELECT 	$1:VendorPaymentStatusesKey::NUMBER(38, 0) AS VendorPaymentStatusesKey, 
		$1:VENDOR::NUMBER(38, 0) AS VENDOR, 
		$1:PAYMENT_STATUS::VARCHAR AS PAYMENT_STATUS, 
		$1:VendorPaymentStatusDescription::VARCHAR AS VendorPaymentStatusDescription, 
		$1:CheckStatusID::NUMBER(38, 0) AS CheckStatusID, 
		$1:CheckStatusDescription::VARCHAR AS CheckStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVendorPaymentStatuses/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
