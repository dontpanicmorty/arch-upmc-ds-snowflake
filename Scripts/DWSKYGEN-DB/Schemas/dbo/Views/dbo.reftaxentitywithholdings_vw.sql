CREATE OR REPLACE VIEW DBO.RefTaxEntityWithholdings_VW
AS 
SELECT 	$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:LevyDocumentKey::NUMBER(38, 0) AS LevyDocumentKey, 
		$1:LevyPayeeKey::NUMBER(38, 0) AS LevyPayeeKey, 
		$1:StateKey::VARCHAR AS StateKey, 
		$1:TaxEntityKey::VARCHAR AS TaxEntityKey, 
		$1:WithholdingRecordType::NUMBER(38, 0) AS WithholdingRecordType, 
		$1:WithholdingRecordTypeDescription::VARCHAR AS WithholdingRecordTypeDescription, 
		$1:WITHHOLDING_TYPE::VARCHAR AS WITHHOLDING_TYPE, 
		$1:WITHHOLD_NUMBER::NUMBER(38, 0) AS WITHHOLD_NUMBER, 
		$1:ACTIVE_FLAG::BOOLEAN AS ACTIVE_FLAG, 
		$1:CREATION_DATE::TIMESTAMP_NTZ AS CREATION_DATE, 
		$1:LEVY_AMOUNT::NUMBER(19, 4) AS LEVY_AMOUNT, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/RefTaxEntityWithholdings/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
