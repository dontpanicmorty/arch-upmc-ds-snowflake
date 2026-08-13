CREATE OR REPLACE VIEW DBO.FactRefunds_VW
AS 
SELECT 	$1:DateCreationKey::NUMBER(38, 0) AS DateCreationKey, 
		$1:DateRefundKey::NUMBER(38, 0) AS DateRefundKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:PayeeKey::NUMBER(38, 0) AS PayeeKey, 
		$1:ReasonCodeKey::NUMBER(38, 0) AS ReasonCodeKey, 
		$1:RefundTypeKey::NUMBER(38, 0) AS RefundTypeKey, 
		$1:PAYMENT_CRITERIA::VARCHAR AS PAYMENT_CRITERIA, 
		$1:REFUND_ID::NUMBER(38, 0) AS REFUND_ID, 
		$1:REFUND_CHECK_NUMBER::VARCHAR AS REFUND_CHECK_NUMBER, 
		$1:REFUND_AMOUNT::NUMBER(19, 2) AS REFUND_AMOUNT, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactRefunds/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

