CREATE OR REPLACE VIEW DBO.DimApprovalGroup_VW
AS 
SELECT 	$1:ApprovalGroupKey::NUMBER(38, 0) AS ApprovalGroupKey, 
		$1:ApprovalLevel::VARCHAR AS ApprovalLevel, 
		$1:ApprovalGroupListing::VARCHAR AS ApprovalGroupListing, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimApprovalGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
