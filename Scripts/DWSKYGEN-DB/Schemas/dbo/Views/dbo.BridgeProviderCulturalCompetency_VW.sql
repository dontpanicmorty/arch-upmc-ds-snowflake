CREATE OR REPLACE VIEW DBO.BridgeProviderCulturalCompetency_VW
AS 
SELECT 	$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:CulturalCompetencyKey::NUMBER(38, 0) AS CulturalCompetencyKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeProviderCulturalCompetency/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);