CREATE OR REPLACE VIEW DBO.DimVisionRedoReason_VW
AS 
SELECT 	$1:VisionRedoReasonKey::NUMBER(38, 0) AS VisionRedoReasonKey, 
		$1:VisionRedoReasonTypeID::NUMBER(38, 0) AS VisionRedoReasonTypeID, 
		$1:VisionRedoReasonType::VARCHAR AS VisionRedoReasonType, 
		$1:VisionRedoReasonCategoryID::NUMBER(38, 0) AS VisionRedoReasonCategoryID, 
		$1:VisionRedoReasonCategory::VARCHAR AS VisionRedoReasonCategory, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVisionRedoReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
