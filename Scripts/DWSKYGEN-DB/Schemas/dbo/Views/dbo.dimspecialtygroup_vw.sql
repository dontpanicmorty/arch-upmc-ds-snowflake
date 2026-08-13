CREATE OR REPLACE VIEW DBO.DimSpecialtyGroup_VW
AS 
SELECT 	$1:SpecialtyGroupKey::NUMBER(38, 0) AS SpecialtyGroupKey, 
		$1:SPECIALTY_GROUP_ID::NUMBER(38, 0) AS SPECIALTY_GROUP_ID, 
		$1:SpecialtyGroupDescription::VARCHAR AS SpecialtyGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSpecialtyGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
