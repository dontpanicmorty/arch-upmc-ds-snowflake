CREATE OR REPLACE VIEW DBO.DimCredentialingRequirements_VW
AS 
SELECT 	$1:CredentialingRequirementKey::NUMBER(38, 0) AS CredentialingRequirementKey, 
		$1:CREDENTIALING_REQUIREMENT_ID::NUMBER(38, 0) AS CREDENTIALING_REQUIREMENT_ID, 
		$1:CredentialingRequirementDescription::VARCHAR AS CredentialingRequirementDescription, 
		$1:DescriptionLong::VARCHAR AS DescriptionLong, 
		$1:ProviderIdentifierType::NUMBER(38, 0) AS ProviderIdentifierType, 
		$1:StateSpecificFlag::BOOLEAN AS StateSpecificFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingRequirements/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
