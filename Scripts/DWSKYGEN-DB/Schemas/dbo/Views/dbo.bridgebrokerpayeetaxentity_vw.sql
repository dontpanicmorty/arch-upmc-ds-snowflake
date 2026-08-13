CREATE OR REPLACE VIEW DBO.BridgeBrokerPayeeTaxEntity_VW
AS 
SELECT 	$1:BrokerPayeeKey::NUMBER(38, 0) AS BrokerPayeeKey, 
		$1:TaxEntityKey::NUMBER(38, 0) AS TaxEntityKey, 
		$1:EffectiveDate::DATE AS EffectiveDate, 
		$1:TerminationDate::DATE AS TerminationDate, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeBrokerPayeeTaxEntity/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
