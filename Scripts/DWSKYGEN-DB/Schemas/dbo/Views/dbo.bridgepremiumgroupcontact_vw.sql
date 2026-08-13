CREATE OR REPLACE VIEW DBO.BridgePremiumGroupContact_VW
AS 
SELECT 	$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:ContactKey::NUMBER(38, 0) AS ContactKey, 
		$1:ContactTypeDescription::VARCHAR AS ContactTypeDescription, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgePremiumGroupContact/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);