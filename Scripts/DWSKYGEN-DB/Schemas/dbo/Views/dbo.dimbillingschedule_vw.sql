CREATE OR REPLACE VIEW DBO.DimBillingSchedule_VW
AS 
SELECT 	$1:BillingScheduleKey::NUMBER(38, 0) AS BillingScheduleKey, 
		$1:BILLING_SCHEDULE_ID::NUMBER(38, 0) AS BILLING_SCHEDULE_ID, 
		$1:BillingSchedule::VARCHAR AS BillingSchedule, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBillingSchedule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
