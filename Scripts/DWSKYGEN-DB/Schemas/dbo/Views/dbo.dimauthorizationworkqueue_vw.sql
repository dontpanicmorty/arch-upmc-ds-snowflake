CREATE OR REPLACE VIEW DBO.DimAuthorizationWorkQueue_VW
AS 
SELECT 	$1:AuthorizationWorkQueueKey::NUMBER(38, 0) AS AuthorizationWorkQueueKey, 
		$1:WORK_QUEUE_ID::NUMBER(38, 0) AS WORK_QUEUE_ID, 
		$1:AuthorizationWorkQueueDescription::VARCHAR AS AuthorizationWorkQueueDescription, 
		$1:AutoReleaseFlag::BOOLEAN AS AutoReleaseFlag, 
		$1:SummaryDaysInQueueThreshold::NUMBER(38, 0) AS SummaryDaysInQueueThreshold, 
		$1:SummaryDaysInHouseThreshold::NUMBER(38, 0) AS SummaryDaysInHouseThreshold, 
		$1:DetailDaysInQueueThreshold::NUMBER(38, 0) AS DetailDaysInQueueThreshold, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationWorkQueue/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
