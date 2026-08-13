CREATE OR REPLACE VIEW DBO.DimPricingRequestStatus_VW
AS 
SELECT 	$1:PricingRequestStatusKey::NUMBER(38, 0) AS PricingRequestStatusKey, 
		$1:PRICING_REQUEST_STATUS_ID::NUMBER(38, 0) AS PRICING_REQUEST_STATUS_ID, 
		$1:PricingRequestStatusDescription::VARCHAR AS PricingRequestStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPricingRequestStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
