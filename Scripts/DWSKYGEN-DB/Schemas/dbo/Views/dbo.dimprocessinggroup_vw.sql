CREATE OR REPLACE VIEW DBO.DimProcessingGroup_VW
AS 
SELECT 	$1:ProcessingGroupKey::NUMBER(38, 0) AS ProcessingGroupKey, 
		$1:PROCESSING_GROUP_ID::NUMBER(38, 0) AS PROCESSING_GROUP_ID, 
		$1:ProcessingGroup::VARCHAR AS ProcessingGroup, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProcessingGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
