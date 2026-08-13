CREATE OR REPLACE VIEW DBO.DimWorkQueue_VW
AS 
SELECT 	$1:WorkQueueKey::NUMBER(38, 0) AS WorkQueueKey, 
		$1:WORK_QUEUE_ID::NUMBER(38, 0) AS WORK_QUEUE_ID, 
		$1:WorkQueueDescription::VARCHAR AS WorkQueueDescription, 
		$1:WorkQueueTypeID::NUMBER(38, 0) AS WorkQueueTypeID, 
		$1:WorkQueueTypeDescription::VARCHAR AS WorkQueueTypeDescription, 
		$1:AutoReleaseFlag::BOOLEAN AS AutoReleaseFlag, 
		$1:SummaryDaysInQueueThreshold::NUMBER(38, 0) AS SummaryDaysInQueueThreshold, 
		$1:SummaryDaysInHouseThreshold::NUMBER(38, 0) AS SummaryDaysInHouseThreshold, 
		$1:DetailDaysInQueueThreshold::NUMBER(38, 0) AS DetailDaysInQueueThreshold, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimWorkQueue/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
