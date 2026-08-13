CREATE OR REPLACE VIEW DBO.BridgeClientContact_VW
AS 
SELECT 	$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:ContactKey::NUMBER(38, 0) AS ContactKey, 
		$1:ContactTypeDescription::VARCHAR AS ContactTypeDescription, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeClientContact/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
