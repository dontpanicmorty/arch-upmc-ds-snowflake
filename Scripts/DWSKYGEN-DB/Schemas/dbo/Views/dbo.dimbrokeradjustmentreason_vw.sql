CREATE OR REPLACE VIEW DBO.DimBrokerAdjustmentReason_VW
AS 
SELECT 	$1:BrokerAdjustmentReasonKey::NUMBER(38, 0) AS BrokerAdjustmentReasonKey, 
		$1:BROKER_ADJUSTMENT_REASON_ID::NUMBER(38, 0) AS BROKER_ADJUSTMENT_REASON_ID, 
		$1:BrokerAdjustmentDescription::VARCHAR AS BrokerAdjustmentDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerAdjustmentReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
