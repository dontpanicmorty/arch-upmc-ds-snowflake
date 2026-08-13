CREATE OR REPLACE VIEW DBO.DimFulfillmentType_VW
AS 
SELECT 	$1:FulfillmentTypeKey::NUMBER(38, 0) AS FulfillmentTypeKey, 
		$1:FULFILLMENT_TYPE::NUMBER(38, 0) AS FULFILLMENT_TYPE, 
		$1:FulfillmentTypeDescription::VARCHAR AS FulfillmentTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimFulfillmentType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
