CREATE OR REPLACE VIEW DBO.DimAdjustmentReason_VW
AS 
SELECT 	$1:AdjustmentReasonKey::NUMBER(38, 0) AS AdjustmentReasonKey, 
		$1:ADJUSTMENT_CODE::NUMBER(38, 0) AS ADJUSTMENT_CODE, 
		$1:AdjustmentDescription::VARCHAR AS AdjustmentDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAdjustmentReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
