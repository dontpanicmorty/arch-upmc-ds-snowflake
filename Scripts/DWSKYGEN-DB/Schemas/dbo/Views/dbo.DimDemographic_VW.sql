CREATE OR REPLACE VIEW DBO.DimDemographic_VW
AS 
SELECT 	$1:MemberDemographicKey::NUMBER(38, 0) AS MemberDemographicKey, 
		$1:EthnicityCode::VARCHAR AS EthnicityCode, 
		$1:EthnicityDescription::VARCHAR AS EthnicityDescription, 
		$1:GenderCode::VARCHAR AS GenderCode, 
		$1:Gender::VARCHAR AS Gender, 
		$1:RelationshipGroup::NUMBER(38, 0) AS RelationshipGroup, 
		$1:RelationshipGroupDescription::VARCHAR AS RelationshipGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDemographic/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

