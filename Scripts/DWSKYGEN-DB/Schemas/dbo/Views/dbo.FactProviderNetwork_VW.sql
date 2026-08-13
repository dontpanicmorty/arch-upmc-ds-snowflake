CREATE OR REPLACE VIEW DBO.FactProviderNetwork_VW
AS 
SELECT 	$1:ContractKey::NUMBER(38, 0) AS ContractKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:PayeeKey::NUMBER(38, 0) AS PayeeKey, 
		$1:ProviderAccessStatusKey::NUMBER(38, 0) AS ProviderAccessStatusKey, 
		$1:FeeScheduleKey::NUMBER(38, 0) AS FeeScheduleKey, 
		$1:AlternativeFeeScheduleKey::NUMBER(38, 0) AS AlternativeFeeScheduleKey, 
		$1:ReimbursementScheduleKey::NUMBER(38, 0) AS ReimbursementScheduleKey, 
		$1:AuthorizationScheduleKey::NUMBER(38, 0) AS AuthorizationScheduleKey, 
		$1:ProviderTerminationReasonKey::NUMBER(38, 0) AS ProviderTerminationReasonKey, 
		$1:ProviderPWPUserFlagKey::NUMBER(38, 0) AS ProviderPWPUserFlagKey, 
		$1:EffectiveDateKey::NUMBER(38, 0) AS EffectiveDateKey, 
		$1:TerminationDateKey::NUMBER(38, 0) AS TerminationDateKey, 
		$1:ProviderNetworkSuspendPlan::VARCHAR AS ProviderNetworkSuspendPlan, 
		$1:PrimaryLocation::VARCHAR AS PrimaryLocation, 
		$1:LIST_IN_DIRECTORY_FLAG::BOOLEAN AS LIST_IN_DIRECTORY_FLAG, 
		$1:CREDENTIALING_DELEGATED_FLAG::BOOLEAN AS CREDENTIALING_DELEGATED_FLAG, 
		$1:OTHER_ID1::VARCHAR AS OTHER_ID1, 
		$1:OTHER_ID2::VARCHAR AS OTHER_ID2, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactProviderNetwork/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
