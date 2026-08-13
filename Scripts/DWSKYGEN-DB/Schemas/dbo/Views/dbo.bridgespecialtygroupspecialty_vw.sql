CREATE OR REPLACE VIEW DBO.BridgeSpecialtyGroupSpecialty_VW
AS 
SELECT 	$1:SpecialtyGroupKey::NUMBER(38, 0) AS SpecialtyGroupKey, 
		$1:SpecialtyKey::NUMBER(38, 0) AS SpecialtyKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeSpecialtyGroupSpecialty/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);