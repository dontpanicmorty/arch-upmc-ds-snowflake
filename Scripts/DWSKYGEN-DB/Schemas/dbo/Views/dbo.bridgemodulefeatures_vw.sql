CREATE OR REPLACE VIEW DBO.BridgeModuleFeatures_VW
AS 
SELECT 	$1:ModuleKey::NUMBER(38, 0) AS ModuleKey, 
		$1:FeatureKey::NUMBER(38, 0) AS FeatureKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeModuleFeatures/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);