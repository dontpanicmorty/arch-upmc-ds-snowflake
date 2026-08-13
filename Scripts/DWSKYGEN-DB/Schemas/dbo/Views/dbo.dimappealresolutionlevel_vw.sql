CREATE OR REPLACE VIEW DBO.DimAppealResolutionLevel_VW
AS 
SELECT 	$1:AppealResolutionLevelKey::NUMBER(38, 0) AS AppealResolutionLevelKey, 
		$1:APPEAL_RESOLUTION_LEVEL_ID::NUMBER(38, 0) AS APPEAL_RESOLUTION_LEVEL_ID, 
		$1:AppealResolutionLevelDescription::VARCHAR AS AppealResolutionLevelDescription, 
		$1:AppealTypeID::NUMBER(38, 0) AS AppealTypeID, 
		$1:AppealTypeDescription::VARCHAR AS AppealTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAppealResolutionLevel/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
