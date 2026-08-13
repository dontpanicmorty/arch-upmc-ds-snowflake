CREATE OR REPLACE VIEW DBO.BridgeDenialGroup_VW
AS 
SELECT 	$1:DenialGroupKey::NUMBER(38, 0) AS DenialGroupKey, 
		$1:DenialCodeKey::NUMBER(38, 0) AS DenialCodeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeDenialGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
