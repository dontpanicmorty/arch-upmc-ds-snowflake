CREATE OR REPLACE VIEW DBO.DimFeeSchedule_VW
AS 
SELECT 	$1:FeeScheduleKey::NUMBER(38, 0) AS FeeScheduleKey, 
		$1:FEE_SCHEDULE_ID::NUMBER(38, 0) AS FEE_SCHEDULE_ID, 
		$1:FeeScheduleDescription::VARCHAR AS FeeScheduleDescription, 
		$1:MarketID::NUMBER(38, 0) AS MarketID, 
		$1:MarketDescription::VARCHAR AS MarketDescription, 
		$1:CodeUniverseID::NUMBER(38, 0) AS CodeUniverseID, 
		$1:CodeUniverseDescription::VARCHAR AS CodeUniverseDescription, 
		$1:FeeScheduleType::NUMBER(38, 0) AS FeeScheduleType, 
		$1:FeeScheduleTypeDescription::VARCHAR AS FeeScheduleTypeDescription, 
		$1:ClientFeeScheduleID::VARCHAR AS ClientFeeScheduleID, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimFeeSchedule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
