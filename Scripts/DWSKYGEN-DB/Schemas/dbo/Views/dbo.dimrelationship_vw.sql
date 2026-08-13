CREATE OR REPLACE VIEW DBO.DimRelationship_VW
AS 
SELECT 	$1:RelationshipKey::NUMBER(38, 0) AS RelationshipKey, 
		$1:RELATIONSHIP_CODE::VARCHAR AS RELATIONSHIP_CODE, 
		$1:RelationshipCodeDescription::VARCHAR AS RelationshipCodeDescription, 
		$1:RelationshipGroup::NUMBER(38, 0) AS RelationshipGroup, 
		$1:RelationshipGroupDescription::VARCHAR AS RelationshipGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRelationship/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
