CREATE OR REPLACE VIEW DBO.FactProviderCredentialingRequirements_VW
AS 
SELECT 	$1:CredentialingRequirementKey::NUMBER(38, 0) AS CredentialingRequirementKey, 
		$1:CredentialingRequirementStatusKey::NUMBER(38, 0) AS CredentialingRequirementStatusKey, 
		$1:CredentialingRequirementStatusReasonKey::NUMBER(38, 0) AS CredentialingRequirementStatusReasonKey, 
		$1:CredentialingSanctionReasonKey::NUMBER(38, 0) AS CredentialingSanctionReasonKey, 
		$1:CredentialingVerificationSourceKey::NUMBER(38, 0) AS CredentialingVerificationSourceKey, 
		$1:DateCredentialingVerificationSourceKey::NUMBER(38, 0) AS DateCredentialingVerificationSourceKey, 
		$1:DateFollowupKey::NUMBER(38, 0) AS DateFollowupKey, 
		$1:DateVerifyKey::NUMBER(38, 0) AS DateVerifyKey, 
		$1:SanctionsPresentFlagKey::NUMBER(38, 0) AS SanctionsPresentFlagKey, 
		$1:StateKey::NUMBER(38, 0) AS StateKey, 
		$1:VerifyDomainSourceKey::NUMBER(38, 0) AS VerifyDomainSourceKey, 
		$1:PROVIDER_CREDENTIALING_PERIOD_REQUIREMENT_ID::NUMBER(38, 0) AS PROVIDER_CREDENTIALING_PERIOD_REQUIREMENT_ID, 
		$1:PROVIDER_CREDENTIALING_PERIOD_ID::NUMBER(38, 0) AS PROVIDER_CREDENTIALING_PERIOD_ID, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactProviderCredentialingRequirements/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
