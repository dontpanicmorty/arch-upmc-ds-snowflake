CREATE OR REPLACE VIEW DBO.DimInventoryClaimType_VW
AS 
SELECT 	$1:InventoryClaimTypeKey::NUMBER(38, 0) AS InventoryClaimTypeKey, 
		$1:INVENTORY_CLAIM_TYPE::NUMBER(38, 0) AS INVENTORY_CLAIM_TYPE, 
		$1:InventoryClaimTypeDescription::VARCHAR AS InventoryClaimTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimInventoryClaimType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
