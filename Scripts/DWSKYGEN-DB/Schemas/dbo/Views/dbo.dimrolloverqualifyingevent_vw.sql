CREATE OR REPLACE VIEW DBO.DimRolloverQualifyingEvent_VW
AS 
SELECT 	$1:RolloverQualifyingEventKey::NUMBER(38, 0) AS RolloverQualifyingEventKey, 
		$1:ROLLOVER_QUALIFYING_EVENT_ID::NUMBER(38, 0) AS ROLLOVER_QUALIFYING_EVENT_ID, 
		$1:RolloverQualifyingEventDescription::VARCHAR AS RolloverQualifyingEventDescription, 
		$1:RolloverAmount::NUMBER(19, 4) AS RolloverAmount, 
		$1:FilterDescription::VARCHAR AS FilterDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRolloverQualifyingEvent/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
