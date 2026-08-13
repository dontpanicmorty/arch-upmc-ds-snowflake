CREATE OR REPLACE VIEW DBO.DimProcessingState_VW
AS 
SELECT 	$1:ProcessingStateKey::NUMBER(38, 0) AS ProcessingStateKey, 
		$1:PROCESSING_STATE::NUMBER(38, 0) AS PROCESSING_STATE, 
		$1:ProcessingStateDescription::VARCHAR AS ProcessingStateDescription, 
		$1:ProcessingStatusID::NUMBER(38, 0) AS ProcessingStatusID, 
		$1:ProcessingStatusDescription::VARCHAR AS ProcessingStatusDescription, 
		$1:ProcessingStatusGroupID::NUMBER(38, 0) AS ProcessingStatusGroupID, 
		$1:ProcessingStatusGroupDescription::VARCHAR AS ProcessingStatusGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProcessingState/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
