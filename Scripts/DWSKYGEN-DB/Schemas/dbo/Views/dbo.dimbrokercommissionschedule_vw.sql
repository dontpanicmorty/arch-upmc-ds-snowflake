CREATE OR REPLACE VIEW DBO.DimBrokerCommissionSchedule_VW
AS 
SELECT 	$1:BrokerCommissionScheduleKey::NUMBER(38, 0) AS BrokerCommissionScheduleKey, 
		$1:BROKER_COMMISSION_SCHEDULE_ID::NUMBER(38, 0) AS BROKER_COMMISSION_SCHEDULE_ID, 
		$1:BrokerCommissionScheduleDescription::VARCHAR AS BrokerCommissionScheduleDescription, 
		$1:BrokerReimbursementMethodID::NUMBER(38, 0) AS BrokerReimbursementMethodID, 
		$1:BrokerReimbursementMethodDescription::VARCHAR AS BrokerReimbursementMethodDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerCommissionSchedule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
