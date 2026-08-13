CREATE OR REPLACE VIEW DBO.FactDocuments_VW
AS 
SELECT 	$1:DateCreatedKey::NUMBER(38, 0) AS DateCreatedKey, 
		$1:DocumentFileTypeKey::NUMBER(38, 0) AS DocumentFileTypeKey, 
		$1:DocumentKey::NUMBER(38, 0) AS DocumentKey, 
		$1:DocumentStatusKey::NUMBER(38, 0) AS DocumentStatusKey, 
		$1:DocumentTypeKey::NUMBER(38, 0) AS DocumentTypeKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:ModuleKey::NUMBER(38, 0) AS ModuleKey, 
		$1:PayeeKey::NUMBER(38, 0) AS PayeeKey, 
		$1:AUTHORIZATION_ID::NUMBER(38, 0) AS AUTHORIZATION_ID, 
		$1:CLAIM_ID::NUMBER(38, 0) AS CLAIM_ID, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactDocuments/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
