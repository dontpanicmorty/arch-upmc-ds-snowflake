CREATE OR REPLACE VIEW DBO.DimAppealTypes_VW
AS 
SELECT 	$1:AppealTypesKey::NUMBER(38, 0) AS AppealTypesKey, 
		$1:APPEAL_TYPE::NUMBER(38, 0) AS APPEAL_TYPE, 
		$1:AppealTypesDescription::VARCHAR AS AppealTypesDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAppealTypes/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
