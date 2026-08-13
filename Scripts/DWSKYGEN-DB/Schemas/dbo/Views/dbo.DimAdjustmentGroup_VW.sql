CREATE OR REPLACE VIEW DBO.DimAdjustmentGroup_VW
AS 
SELECT 	$1:AdjustmentGroupKey::NUMBER(38, 0) AS AdjustmentGroupKey, 
		$1:AdjustmentGroupListing::VARCHAR AS AdjustmentGroupListing, 
		$1:AdjustmentGroupDescription::VARCHAR AS AdjustmentGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAdjustmentGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
