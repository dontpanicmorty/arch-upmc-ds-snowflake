CREATE OR REPLACE VIEW DBO.BridgeEnrolleeSupplementalIdentifier_VW
AS 
SELECT 	$1:EnrolleeSupplementalIdentifierKey::NUMBER(38, 0) AS EnrolleeSupplementalIdentifierKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeEnrolleeSupplementalIdentifier/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);