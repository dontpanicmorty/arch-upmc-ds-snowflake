CREATE OR REPLACE VIEW DBO.FactBrokerCommissionsDetail_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BillingTypeKey::NUMBER(38, 0) AS BillingTypeKey, 
		$1:DateBillingPeriodKey::NUMBER(38, 0) AS DateBillingPeriodKey, 
		$1:BrokerCommissionStatusKey::NUMBER(38, 0) AS BrokerCommissionStatusKey, 
		$1:BrokerCommissionScheduleKey::NUMBER(38, 0) AS BrokerCommissionScheduleKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:InvoiceItemTypeKey::NUMBER(38, 0) AS InvoiceItemTypeKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:EnrolleeContractKey::NUMBER(38, 0) AS EnrolleeContractKey, 
		$1:SubscriberContractTypeKey::NUMBER(38, 0) AS SubscriberContractTypeKey, 
		$1:BROKER_ADJUDICATE_CYCLE_ID::NUMBER(38, 0) AS BROKER_ADJUDICATE_CYCLE_ID, 
		$1:ENROLLEE_ID::NUMBER(38, 0) AS ENROLLEE_ID, 
		$1:SUBSCRIBER_ID::VARCHAR AS SUBSCRIBER_ID, 
		$1:INVOICE_ID::NUMBER(38, 0) AS INVOICE_ID, 
		$1:INVOICE_NUMBER::VARCHAR AS INVOICE_NUMBER, 
		$1:APPLIED_AMOUNT::NUMBER(19, 4) AS APPLIED_AMOUNT, 
		$1:AMOUNT_ELIG_FOR_BROKER_COMMISSIONS::NUMBER(19, 4) AS AMOUNT_ELIG_FOR_BROKER_COMMISSIONS, 
		$1:BILLED_PREMIUM::NUMBER(19, 4) AS BILLED_PREMIUM, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBrokerCommissionsDetail/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
