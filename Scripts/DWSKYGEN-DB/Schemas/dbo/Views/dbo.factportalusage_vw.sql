CREATE OR REPLACE VIEW DBO.FactPortalUsage_VW
AS 
SELECT 	$1:DateKey::NUMBER(38, 0) AS DateKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:FeatureKey::NUMBER(38, 0) AS FeatureKey, 
		$1:PortalKey::NUMBER(38, 0) AS PortalKey, 
		$1:TimeKey::NUMBER(38, 0) AS TimeKey, 
		$1:UsageCount::NUMBER(38, 0) AS UsageCount, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPortalUsage/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
