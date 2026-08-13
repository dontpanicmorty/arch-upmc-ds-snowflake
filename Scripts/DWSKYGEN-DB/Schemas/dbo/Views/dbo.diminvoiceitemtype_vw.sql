CREATE OR REPLACE VIEW DBO.DimInvoiceItemType_VW
AS 
SELECT 	$1:InvoiceItemTypeKey::NUMBER(38, 0) AS InvoiceItemTypeKey, 
		$1:INVOICE_ITEM_TYPE::NUMBER(38, 0) AS INVOICE_ITEM_TYPE, 
		$1:InvoiceItemType::VARCHAR AS InvoiceItemType, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimInvoiceItemType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
