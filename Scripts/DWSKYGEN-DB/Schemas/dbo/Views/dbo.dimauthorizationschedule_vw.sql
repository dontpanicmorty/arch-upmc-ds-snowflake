CREATE OR REPLACE VIEW DBO.DimAuthorizationSchedule_VW
AS 
SELECT 	$1:AuthorizationScheduleKey::NUMBER(38, 0) AS AuthorizationScheduleKey, 
		$1:AUTHORIZATION_SCHEDULE_ID::NUMBER(38, 0) AS AUTHORIZATION_SCHEDULE_ID, 
		$1:AuthorizationScheduleDescription::VARCHAR AS AuthorizationScheduleDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationSchedule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
