CREATE OR REPLACE VIEW DBO.DimAuthorizationGuideline_VW
AS 
SELECT 	$1:AuthorizationGuidelineKey::NUMBER(38, 0) AS AuthorizationGuidelineKey, 
		$1:AUTH_GUIDELINE_ID::NUMBER(38, 0) AS AUTH_GUIDELINE_ID, 
		$1:AuthorizationGuidelineDescription::VARCHAR AS AuthorizationGuidelineDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationGuideline/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
