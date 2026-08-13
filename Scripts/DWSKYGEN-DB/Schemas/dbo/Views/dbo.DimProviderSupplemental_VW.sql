CREATE OR REPLACE VIEW DBO.DimProviderSupplemental_VW
AS 
SELECT 	$1:ProviderSupplementalKey::NUMBER(38, 0) AS ProviderSupplementalKey, 
		$1:PROVIDER_ID::NUMBER(38, 0) AS PROVIDER_ID, 
		$1:PSI_ID::VARCHAR AS PSI_ID, 
		$1:ProviderSupplementalState::VARCHAR AS ProviderSupplementalState, 
		$1:ProviderSupplementalIdentificationNumber::VARCHAR AS ProviderSupplementalIdentificationNumber, 
		$1:ProviderSupplementalIssueDate::DATE AS ProviderSupplementalIssueDate, 
		$1:ProviderSupplementalExpirationDate::DATE AS ProviderSupplementalExpirationDate, 
		$1:ProviderSupplementalIdentifierTypeID::NUMBER(38, 0) AS ProviderSupplementalIdentifierTypeID, 
		$1:ProviderSupplementalIdentifierTypeDescription::VARCHAR AS ProviderSupplementalIdentifierTypeDescription, 
		$1:ProviderSupplementalLicenseFlag::BOOLEAN AS ProviderSupplementalLicenseFlag, 
		$1:ProviderSupplementalLicenseDescription::VARCHAR AS ProviderSupplementalLicenseDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProviderSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
