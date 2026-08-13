CREATE OR REPLACE VIEW DBO.DimSubcode_VW
AS 
SELECT 	$1:SubcodeKey::NUMBER(38, 0) AS SubcodeKey, 
		$1:SUBCODE::VARCHAR AS SUBCODE, 
		$1:SubcodeDescription::VARCHAR AS SubcodeDescription, 
		$1:SubcodeType::NUMBER(38, 0) AS SubcodeType, 
		$1:SubcodeTypeDescription::VARCHAR AS SubcodeTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSubcode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
