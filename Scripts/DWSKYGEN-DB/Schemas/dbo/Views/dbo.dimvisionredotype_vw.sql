CREATE OR REPLACE VIEW DBO.DimVisionRedoType_VW
AS 
SELECT 	$1:VisionRedoTypeKey::NUMBER(38, 0) AS VisionRedoTypeKey, 
		$1:VisionRedoTypeID::NUMBER(38, 0) AS VisionRedoTypeID, 
		$1:VisionRedoType::VARCHAR AS VisionRedoType, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVisionRedoType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
