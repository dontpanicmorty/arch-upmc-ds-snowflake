CREATE OR REPLACE VIEW DBO.FactBrokerCommissionSchedules_VW
AS 
SELECT 	$1:ActiveFlagKey::NUMBER(38, 0) AS ActiveFlagKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BrokerCommissionScheduleKey::NUMBER(38, 0) AS BrokerCommissionScheduleKey, 
		$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:RECORD_TYPE::NUMBER(38, 0) AS RECORD_TYPE, 
		$1:BROKER_PARTICIPATION_ID::NUMBER(38, 0) AS BROKER_PARTICIPATION_ID, 
		$1:STARTING_PERIOD::NUMBER(38, 0) AS STARTING_PERIOD, 
		$1:ENDING_PERIOD::NUMBER(38, 0) AS ENDING_PERIOD, 
		$1:AMOUNT::NUMBER(19, 4) AS AMOUNT, 
		$1:PERCENTAGE::REAL AS PERCENTAGE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBrokerCommissionSchedules/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
