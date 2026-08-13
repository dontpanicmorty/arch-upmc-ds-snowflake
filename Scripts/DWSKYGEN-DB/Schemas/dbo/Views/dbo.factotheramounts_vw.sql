CREATE OR REPLACE VIEW DBO.FactOtherAmounts_VW
AS 
SELECT 	$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:OtherAmountIndicatorKey::NUMBER(38, 0) AS OtherAmountIndicatorKey, 
		$1:CLAIM_ID::NUMBER(38, 0) AS CLAIM_ID, 
		$1:ITEM_NUMBER::NUMBER(38, 0) AS ITEM_NUMBER, 
		$1:OTHER_AMOUNT::NUMBER(19, 2) AS OTHER_AMOUNT, 
		$1:NOTES::VARCHAR AS NOTES, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactOtherAmounts/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
