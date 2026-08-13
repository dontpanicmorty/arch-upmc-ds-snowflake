CREATE OR REPLACE VIEW DBO.DimVisionOrderType_VW
AS 
SELECT 	$1:VisionOrderTypeKey::NUMBER(38, 0) AS VisionOrderTypeKey, 
		$1:VisionOrderTypeID::NUMBER(38, 0) AS VisionOrderTypeID, 
		$1:VisionOrderType::VARCHAR AS VisionOrderType, 
		$1:FrameOrderTypeID::NUMBER(38, 0) AS FrameOrderTypeID, 
		$1:FrameOrderType::VARCHAR AS FrameOrderType, 
		$1:LensOrderTypeID::NUMBER(38, 0) AS LensOrderTypeID, 
		$1:LensOrderType::VARCHAR AS LensOrderType, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVisionOrderType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
