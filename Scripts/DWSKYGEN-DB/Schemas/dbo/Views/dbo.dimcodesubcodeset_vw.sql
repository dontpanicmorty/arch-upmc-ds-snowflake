CREATE OR REPLACE VIEW DBO.DimCodeSubcodeSet_VW
AS 
SELECT 	$1:CodeSubcodeSetKey::NUMBER(38, 0) AS CodeSubcodeSetKey, 
		$1:CODE_SUBCODE_SET_ID::NUMBER(38, 0) AS CODE_SUBCODE_SET_ID, 
		$1:CodeSubcodeSetName::VARCHAR AS CodeSubcodeSetName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCodeSubcodeSet/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
