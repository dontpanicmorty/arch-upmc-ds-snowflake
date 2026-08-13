CREATE OR REPLACE VIEW DBO.DimClaimInventoryType_VW
AS 
SELECT 	$1:ClaimInventoryTypeKey::NUMBER(38, 0) AS ClaimInventoryTypeKey, 
		$1:CLAIM_INVENTORY_TYPE::NUMBER(38, 0) AS CLAIM_INVENTORY_TYPE, 
		$1:ClaimInventoryTypeDescription::VARCHAR AS ClaimInventoryTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimClaimInventoryType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
