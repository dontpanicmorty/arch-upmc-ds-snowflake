CREATE OR REPLACE VIEW DBO.DimVisionOrderStatus_VW
AS 
SELECT 	$1:VisionOrderStatusKey::NUMBER(38, 0) AS VisionOrderStatusKey, 
		$1:VisionOrderStatusID::NUMBER(38, 0) AS VisionOrderStatusID, 
		$1:VisionOrderStatus::VARCHAR AS VisionOrderStatus, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVisionOrderStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
