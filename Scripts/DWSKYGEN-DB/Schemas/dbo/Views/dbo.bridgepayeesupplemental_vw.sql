CREATE OR REPLACE VIEW DBO.BridgePayeeSupplemental_VW
AS 
SELECT 	$1:PayeeSupplementalIdentifierKey::NUMBER(38, 0) AS PayeeSupplementalIdentifierKey, 
		$1:PayeeKey::NUMBER(38, 0) AS PayeeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgePayeeSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);