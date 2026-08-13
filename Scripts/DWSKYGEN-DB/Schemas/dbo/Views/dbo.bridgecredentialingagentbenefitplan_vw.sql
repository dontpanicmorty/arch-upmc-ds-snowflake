CREATE OR REPLACE VIEW DBO.BridgeCredentialingAgentBenefitPlan_VW
AS 
SELECT 	$1:CredentialingAgentKey::NUMBER(38, 0) AS CredentialingAgentKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeCredentialingAgentBenefitPlan/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

