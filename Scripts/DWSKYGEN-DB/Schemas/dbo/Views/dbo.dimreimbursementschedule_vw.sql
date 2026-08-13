CREATE OR REPLACE VIEW DBO.DimReimbursementSchedule_VW
AS 
SELECT 	$1:ReimbursementScheduleKey::NUMBER(38, 0) AS ReimbursementScheduleKey, 
		$1:REIMBURSEMENT_SCHEDULE_ID::NUMBER(38, 0) AS REIMBURSEMENT_SCHEDULE_ID, 
		$1:ReimbursementScheduleDescription::VARCHAR AS ReimbursementScheduleDescription, 
		$1:FeeScheduleID::NUMBER(38, 0) AS FeeScheduleID, 
		$1:FeeScheduleDescription::VARCHAR AS FeeScheduleDescription, 
		$1:ClientFeeScheduleID::VARCHAR AS ClientFeeScheduleID, 
		$1:FeeScheduleType::NUMBER(38, 0) AS FeeScheduleType, 
		$1:FeeScheduleTypeDescription::VARCHAR AS FeeScheduleTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimReimbursementSchedule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
