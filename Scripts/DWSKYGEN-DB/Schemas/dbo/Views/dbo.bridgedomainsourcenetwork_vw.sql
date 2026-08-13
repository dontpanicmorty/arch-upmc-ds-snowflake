CREATE OR REPLACE VIEW DBO.BridgeDomainSourceNetwork_VW
AS 
SELECT 	$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeDomainSourceNetwork/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);