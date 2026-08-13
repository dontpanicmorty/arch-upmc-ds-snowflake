CREATE OR REPLACE VIEW DBO.FactBrokerCommissionAdjustmentDetails_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BrokerAdjustmentTypeKey::NUMBER(38, 0) AS BrokerAdjustmentTypeKey, 
		$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:CheckKey::NUMBER(38, 0) AS CheckKey, 
		$1:DateBillingPeriodKey::NUMBER(38, 0) AS DateBillingPeriodKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:RecordType::NUMBER(38, 0) AS RecordType, 
		$1:BROKER_ADJUSTMENT_LEDGER_ID::NUMBER(38, 0) AS BROKER_ADJUSTMENT_LEDGER_ID, 
		$1:BROKER_ADJUDICATE_CYCLE_ID::NUMBER(38, 0) AS BROKER_ADJUDICATE_CYCLE_ID,
		$1:APPLIED_BROKER_ADJUDICATE_CYCLE_ID::NUMBER(38, 0) AS APPLIED_BROKER_ADJUDICATE_CYCLE_ID,
		$1:ENROLLEE_ID::NUMBER(38, 0) AS ENROLLEE_ID, 
		$1:InvoiceNumber::VARCHAR AS InvoiceNumber, 
		$1:AdjustmentAmount::NUMBER(19, 4) AS AdjustmentAmount, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBrokerCommissionAdjustmentDetails/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
