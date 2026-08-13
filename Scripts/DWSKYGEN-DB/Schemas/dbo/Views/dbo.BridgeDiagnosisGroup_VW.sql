CREATE OR REPLACE VIEW DBO.BridgeDiagnosisGroup_VW
AS 
SELECT 	$1:DiagnosisGroupKey::NUMBER(38, 0) AS DiagnosisGroupKey, 
		$1:DiagnosisCodeKey::NUMBER(38, 0) AS DiagnosisCodeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeDiagnosisGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);