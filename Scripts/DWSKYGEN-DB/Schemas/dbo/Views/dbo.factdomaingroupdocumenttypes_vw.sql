CREATE OR REPLACE VIEW DBO.FactDomainGroupDocumentTypes_VW
AS 
SELECT 	$1:DomainGroupKey::NUMBER(38, 0) AS DomainGroupKey, 
		$1:DocumentTypeKey::NUMBER(38, 0) AS DocumentTypeKey, 
		$1:DocumentAccessLevelKey::NUMBER(38, 0) AS DocumentAccessLevelKey, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactDomainGroupDocumentTypes/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
