CREATE OR REPLACE VIEW DBO.BridgeDiagCodeSetCode_VW
AS 
SELECT 	$1:DiagnosisCodeSetKey::NUMBER(38, 0) AS DiagnosisCodeSetKey, 
		$1:DiagnosisCodeKey::NUMBER(38, 0) AS DiagnosisCodeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeDiagCodeSetCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);