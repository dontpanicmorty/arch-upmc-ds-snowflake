CREATE OR REPLACE VIEW DBO.FactBrokerParticipation_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BrokerCommissionScheduleKey::NUMBER(38, 0) AS BrokerCommissionScheduleKey, 
		$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:BROKER_PARTICIPATION_ID::NUMBER(38, 0) AS BROKER_PARTICIPATION_ID, 
		$1:ActiveFlag::BOOLEAN AS ActiveFlag, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBrokerParticipation/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
