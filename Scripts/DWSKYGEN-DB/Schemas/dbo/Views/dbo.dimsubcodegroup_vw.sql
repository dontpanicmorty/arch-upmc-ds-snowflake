CREATE OR REPLACE VIEW DBO.DimSubcodeGroup_VW
AS 
SELECT 	$1:SubcodeGroupKey::NUMBER(38, 0) AS SubcodeGroupKey, 
		$1:SUBCODE_GROUP::NUMBER(38, 0) AS SUBCODE_GROUP, 
		$1:SubcodeGroupDescription::VARCHAR AS SubcodeGroupDescription, 
		$1:SubcodeType::NUMBER(38, 0) AS SubcodeType, 
		$1:SubcodeTypeDescription::VARCHAR AS SubcodeTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSubcodeGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
