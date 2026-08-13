CREATE OR REPLACE VIEW DBO.FactNetworkReimbursementExceptions_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:AlternativeFeeScheduleKey::NUMBER(38, 0) AS AlternativeFeeScheduleKey, 
		$1:AuthorizationScheduleKey::NUMBER(38, 0) AS AuthorizationScheduleKey, 
		$1:PayeeKey::NUMBER(38, 0) AS PayeeKey, 
		$1:ReimbursementScheduleKey::NUMBER(38, 0) AS ReimbursementScheduleKey, 
		$1:LAST_MODIFIED_DATE_TIME::TIMESTAMP_NTZ AS LAST_MODIFIED_DATE_TIME, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactNetworkReimbursementExceptions/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
