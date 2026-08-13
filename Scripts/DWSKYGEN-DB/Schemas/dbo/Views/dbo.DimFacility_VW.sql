CREATE OR REPLACE VIEW DBO.DimFacility_VW
AS 
SELECT 	$1:FacilityKey::NUMBER(38, 0) AS FacilityKey, 
		$1:FacilityID::NUMBER(38, 0) AS FacilityID, 
		$1:FacilityName::VARCHAR AS FacilityName, 
		$1:FacilityAddress::VARCHAR AS FacilityAddress, 
		$1:FacilityCity::VARCHAR AS FacilityCity, 
		$1:FacilityState::VARCHAR AS FacilityState, 
		$1:FacilityZip::VARCHAR AS FacilityZip, 
		$1:FacilityMedicaidNumber::VARCHAR AS FacilityMedicaidNumber, 
		$1:FacilityNPI::VARCHAR AS FacilityNPI, 
		$1:FacilityType::NUMBER(38, 0) AS FacilityType, 
		$1:FacilityTypeDescription::VARCHAR AS FacilityTypeDescription, 
		$1:HospitalSystemID::NUMBER(38, 0) AS HospitalSystemID, 
		$1:HospitalSystem::VARCHAR AS HospitalSystem, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimFacility/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
