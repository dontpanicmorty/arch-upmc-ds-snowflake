CREATE OR REPLACE VIEW DBO.DimVendor_VW
AS 
SELECT 	$1:VendorKey::NUMBER(38, 0) AS VendorKey, 
		$1:VENDOR::NUMBER(38, 0) AS VENDOR, 
		$1:VendorDescription::VARCHAR AS VendorDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVendor/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
