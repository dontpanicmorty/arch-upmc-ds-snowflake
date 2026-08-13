CREATE OR REPLACE VIEW DBO.DimFulfillmentSources_VW
AS 
SELECT 	$1:FulfillmentSourceKey::NUMBER(38, 0) AS FulfillmentSourceKey, 
		$1:FULFILLMENT_SOURCE::NUMBER(38, 0) AS FULFILLMENT_SOURCE, 
		$1:FulfillmentSourceDescription::VARCHAR AS FulfillmentSourceDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimFulfillmentSources/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
