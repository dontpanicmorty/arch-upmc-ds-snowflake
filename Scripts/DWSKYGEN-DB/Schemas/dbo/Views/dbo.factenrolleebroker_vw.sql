CREATE OR REPLACE VIEW DBO.FactEnrolleeBroker_VW
AS 
SELECT 	$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BrokerCommissionScheduleKey::NUMBER(38, 0) AS BrokerCommissionScheduleKey, 
		$1:EnrolleeBrokerCount::NUMBER(38, 0) AS EnrolleeBrokerCount, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactEnrolleeBroker/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
