CREATE OR REPLACE VIEW DBO.FactSecurityRoles_VW
AS 
SELECT 	$1:DomainKey::NUMBER(38, 0) AS DomainKey, 
		$1:DomainGroupKey::NUMBER(38, 0) AS DomainGroupKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:FeatureKey::NUMBER(38, 0) AS FeatureKey, 
		$1:ModuleKey::NUMBER(38, 0) AS ModuleKey, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactSecurityRoles/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
