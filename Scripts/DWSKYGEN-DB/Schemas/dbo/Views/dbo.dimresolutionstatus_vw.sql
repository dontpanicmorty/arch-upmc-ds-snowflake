CREATE OR REPLACE VIEW DBO.DimResolutionStatus_VW
AS 
SELECT 	$1:ResolutionStatusKey::NUMBER(38, 0) AS ResolutionStatusKey, 
		$1:RESOLUTION_STATUS_ID::NUMBER(38, 0) AS RESOLUTION_STATUS_ID, 
		$1:ResolutionStatusDescription::VARCHAR AS ResolutionStatusDescription, 
		$1:AppealResolutionCategoryID::NUMBER(38, 0) AS AppealResolutionCategoryID, 
		$1:AppealResolutionCategoryDescription::VARCHAR AS AppealResolutionCategoryDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimResolutionStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
