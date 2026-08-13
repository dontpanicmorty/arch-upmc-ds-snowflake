CREATE OR REPLACE VIEW DBO.DimVendorReasonCode_VW
AS 
SELECT 	$1:VendorReasonCodeKey::NUMBER(38, 0) AS VendorReasonCodeKey, 
		$1:VENDOR::NUMBER(38, 0) AS VENDOR, 
		$1:REASON_CODE::NUMBER(38, 0) AS REASON_CODE, 
		$1:VendorReasonCodeDescription::VARCHAR AS VendorReasonCodeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVendorReasonCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
