CREATE OR REPLACE VIEW DBO.DimCulturalCompetency_VW
AS 
SELECT 	$1:CulturalCompetencyKey::NUMBER(38, 0) AS CulturalCompetencyKey, 
		$1:CULTURAL_COMPETENCY_COURSE::NUMBER(38, 0) AS CULTURAL_COMPETENCY_COURSE, 
		$1:CulturalCompetencyDescription::VARCHAR AS CulturalCompetencyDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCulturalCompetency/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
