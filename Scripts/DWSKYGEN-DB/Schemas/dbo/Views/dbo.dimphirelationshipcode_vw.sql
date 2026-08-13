CREATE OR REPLACE VIEW DBO.DimPHIRelationshipCode_VW
AS 
SELECT 	$1:PHIRelationshipCodeKey::NUMBER(38, 0) AS PHIRelationshipCodeKey, 
		$1:PHI_RELATIONSHIP_CODE::NUMBER(38, 0) AS PHI_RELATIONSHIP_CODE, 
		$1:PHIRelationshipCodeDescription::VARCHAR AS PHIRelationshipCodeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPHIRelationshipCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);