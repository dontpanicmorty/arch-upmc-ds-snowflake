CREATE OR REPLACE VIEW DBO.FactBenefitPlanThresholds_VW
AS 
SELECT 	$1:BenefitAccumulatorScopeKey::NUMBER(38, 0) AS BenefitAccumulatorScopeKey, 
		$1:BenefitAccumulatorTypeKey::NUMBER(38, 0) AS BenefitAccumulatorTypeKey, 
		$1:BenefitLevelKey::NUMBER(38, 0) AS BenefitLevelKey, 
		$1:BenefitPeriodTypeKey::NUMBER(38, 0) AS BenefitPeriodTypeKey, 
		$1:BenefitPlanEscalationTierKey::NUMBER(38, 0) AS BenefitPlanEscalationTierKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:CombineDeductiblesFlagKey::NUMBER(38, 0) AS CombineDeductiblesFlagKey, 
		$1:DateBenefitPlanThresholdEffectiveKey::NUMBER(38, 0) AS DateBenefitPlanThresholdEffectiveKey, 
		$1:DateBenefitPlanThresholdTerminationKey::NUMBER(38, 0) AS DateBenefitPlanThresholdTerminationKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:SubscriberContractTypeKey::NUMBER(38, 0) AS SubscriberContractTypeKey, 
		$1:RecordType::NUMBER(38, 0) AS RecordType, 
		$1:BenefitPlanThresholdDescription::VARCHAR AS BenefitPlanThresholdDescription, 
		$1:BenefitEscalation::NUMBER(38, 0) AS BenefitEscalation, 
		$1:THRESHOLD_AMOUNT::NUMBER(19, 4) AS THRESHOLD_AMOUNT, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBenefitPlanThresholds/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
