CREATE OR REPLACE VIEW DBO.FactInvoiceRevenueAdjustment_VW
AS 
SELECT 	$1:DateCreateKey::NUMBER(38, 0) AS DateCreateKey, 
		$1:DatePostKey::NUMBER(38, 0) AS DatePostKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:INVOICE_REVENUE_ADJUSTMENT_ID::NUMBER(38, 0) AS INVOICE_REVENUE_ADJUSTMENT_ID, 
		$1:INVOICE_ID::NUMBER(38, 0) AS INVOICE_ID, 
		$1:CREATE_DATE::TIMESTAMP_NTZ AS CREATE_DATE, 
		$1:AMOUNT::NUMBER(19, 4) AS AMOUNT, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactInvoiceRevenueAdjustment/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
