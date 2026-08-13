CREATE OR REPLACE VIEW DBO.DimClaimInventoryIssueTypes_VW
AS 
SELECT 	$1:ClaimInventoryIssueTypeKey::NUMBER(38, 0) AS ClaimInventoryIssueTypeKey, 
		$1:CLAIM_INVENTORY_ISSUE_TYPE::NUMBER(38, 0) AS CLAIM_INVENTORY_ISSUE_TYPE, 
		$1:ClaimInventoryIssueTypeDescription::VARCHAR AS ClaimInventoryIssueTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDateTime::TIMESTAMP_NTZ AS RecordCreateDateTime, 
		$1:RecordUpdateDateTime::TIMESTAMP_NTZ AS RecordUpdateDateTime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimClaimInventoryIssueTypes/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
