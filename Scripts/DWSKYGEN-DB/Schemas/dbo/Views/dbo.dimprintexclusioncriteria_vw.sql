CREATE OR REPLACE VIEW DBO.DimPrintExclusionCriteria_VW
AS 
SELECT 	$1:PrintExclusionCriteriaKey::NUMBER(38, 0) AS PrintExclusionCriteriaKey, 
		$1:PRINT_EXCLUSION_CRITERIA::NUMBER(38, 0) AS PRINT_EXCLUSION_CRITERIA, 
		$1:PrintExclusionCriteriaDescription::VARCHAR AS PrintExclusionCriteriaDescription, 
		$1:Report_Group::VARCHAR AS Report_Group, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPrintExclusionCriteria/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
