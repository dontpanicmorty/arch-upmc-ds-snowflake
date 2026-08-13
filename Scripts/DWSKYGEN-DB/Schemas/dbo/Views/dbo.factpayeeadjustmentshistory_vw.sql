CREATE OR REPLACE VIEW DBO.FactPayeeAdjustmentsHistory_VW
AS 
SELECT 	$1:AdjustmentReasonKey::NUMBER(38, 0) AS AdjustmentReasonKey, 
		$1:CheckKey::NUMBER(38, 0) AS CheckKey, 
		$1:CompensationAccountKey::NUMBER(38, 0) AS CompensationAccountKey, 
		$1:ConsumedFlagKey::NUMBER(38, 0) AS ConsumedFlagKey, 
		$1:DateCreationKey::NUMBER(38, 0) AS DateCreationKey, 
		$1:DatePaidKey::NUMBER(38, 0) AS DatePaidKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:PayeeKey::NUMBER(38, 0) AS PayeeKey, 
		$1:PaymentGroupKey::NUMBER(38, 0) AS PaymentGroupKey, 
		$1:ProcessingGroupKey::NUMBER(38, 0) AS ProcessingGroupKey, 
		$1:ProcessingStateKey::NUMBER(38, 0) AS ProcessingStateKey, 
		$1:AdjustmentNumber::NUMBER(38, 0) AS AdjustmentNumber, 
		$1:AdjudicateCycleID::NUMBER(38, 0) AS AdjudicateCycleID, 
		$1:PAYMENT_CYCLE_ID::NUMBER(38, 0) AS PAYMENT_CYCLE_ID, 
		$1:Explanation::VARCHAR AS Explanation, 
		$1:RefundID::NUMBER(38, 0) AS RefundID, 
		$1:PAID_AMOUNT::NUMBER(19, 4) AS PAID_AMOUNT, 
		$1:SYS_START_TIME::TIMESTAMP_NTZ AS SYS_START_TIME, 
		$1:SYS_END_TIME::TIMESTAMP_NTZ AS SYS_END_TIME, 
		$1:Partition::NUMBER(38, 0) AS Partition,
		$1:PRIOR_PERIOD_RECOVERY_PAYMENT_CYCLE_ID::NUMBER(38, 0) AS PRIOR_PERIOD_RECOVERY_PAYMENT_CYCLE_ID,
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPayeeAdjustmentsHistory/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);