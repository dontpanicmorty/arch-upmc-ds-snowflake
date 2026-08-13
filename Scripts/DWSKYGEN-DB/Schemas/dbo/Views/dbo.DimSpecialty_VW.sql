CREATE OR REPLACE VIEW DBO.DimSpecialty_VW
AS 
SELECT 	$1:SpecialtyKey::NUMBER(38, 0) AS SpecialtyKey, 
		$1:SPECIALTY_ID::NUMBER(38, 0) AS SPECIALTY_ID, 
		$1:SpecialtyDescription::VARCHAR AS SpecialtyDescription, 
		$1:TaxonomyCode::VARCHAR AS TaxonomyCode, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSpecialty/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
