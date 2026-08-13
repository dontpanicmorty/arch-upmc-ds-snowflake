CREATE OR REPLACE VIEW DBO.DimBrokerAdjustmentType_VW
AS 
SELECT 	$1:BrokerAdjustmentTypeKey::NUMBER(38, 0) AS BrokerAdjustmentTypeKey, 
		$1:BROKER_ADJUSTMENT_TYPE::NUMBER(38, 0) AS BROKER_ADJUSTMENT_TYPE, 
		$1:BrokerAdjustmentTypeDescription::VARCHAR AS BrokerAdjustmentTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerAdjustmentType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
