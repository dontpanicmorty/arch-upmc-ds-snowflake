CREATE OR REPLACE VIEW DBO.DimWellnessProgram_VW
AS 
SELECT 	$1:WellnessProgramKey::NUMBER(38, 0) AS WellnessProgramKey, 
		$1:WELLNESS_PROGRAM_ID::NUMBER(38, 0) AS WELLNESS_PROGRAM_ID, 
		$1:WellnessProgramDescription::VARCHAR AS WellnessProgramDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimWellnessProgram/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
