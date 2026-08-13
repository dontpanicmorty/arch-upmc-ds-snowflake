CREATE OR REPLACE VIEW DBO.FactEnterpriseSystemFeatureUsage_VW
AS 
SELECT 	$1:LogTypeKey::NUMBER(38, 0) AS LogTypeKey, 
		$1:ModuleKey::NUMBER(38, 0) AS ModuleKey, 
		$1:FeatureKey::NUMBER(38, 0) AS FeatureKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:DateCreationKey::NUMBER(38, 0) AS DateCreationKey, 
		$1:TimeCreationKey::NUMBER(38, 0) AS TimeCreationKey, 
		$1:LOG_ID::NUMBER(38, 0) AS LOG_ID, 
		$1:IsClaimLog::BOOLEAN AS IsClaimLog, 
		$1:IsAuthLog::BOOLEAN AS IsAuthLog, 
		$1:MESSAGE::VARCHAR AS MESSAGE, 
		$1:CREATION_DATE::TIMESTAMP_NTZ AS CREATION_DATE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactEnterpriseSystemFeatureUsage/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
