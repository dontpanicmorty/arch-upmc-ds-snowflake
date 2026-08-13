CREATE OR REPLACE VIEW DBO.FactProviderCredentialing_VW
AS 
SELECT 	$1:CredentialingAgentKey::NUMBER(38, 0) AS CredentialingAgentKey, 
		$1:CredentialingPeriodStatusKey::NUMBER(38, 0) AS CredentialingPeriodStatusKey, 
		$1:CredentialingPeriodStatusReasonKey::NUMBER(38, 0) AS CredentialingPeriodStatusReasonKey, 
		$1:CredentialingPeriodTypeKey::NUMBER(38, 0) AS CredentialingPeriodTypeKey, 
		$1:DateApplicationReceivedKey::NUMBER(38, 0) AS DateApplicationReceivedKey, 
		$1:DateCredentialingCompleteKey::NUMBER(38, 0) AS DateCredentialingCompleteKey, 
		$1:DateCredentialingPeriodOpenKey::NUMBER(38, 0) AS DateCredentialingPeriodOpenKey, 
		$1:DateRecredentialKey::NUMBER(38, 0) AS DateRecredentialKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:ProviderCredentialingPeriodId::NUMBER(38, 0) AS ProviderCredentialingPeriodId, 
		$1:PeriodLength::NUMBER(38, 0) AS PeriodLength, 
		$1:Credentialed_CD_TAT::NUMBER(38, 0) AS Credentialed_CD_TAT, 
		$1:ReCredentialed_CD_TAT::NUMBER(38, 0) AS ReCredentialed_CD_TAT, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactProviderCredentialing/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
