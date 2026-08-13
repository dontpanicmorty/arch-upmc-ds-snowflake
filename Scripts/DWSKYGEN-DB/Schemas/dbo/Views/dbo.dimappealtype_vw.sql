CREATE OR REPLACE VIEW DBO.DimAppealType_VW
AS 
SELECT 	$1:AppealTypeKey::NUMBER(38, 0) AS AppealTypeKey, 
		$1:APPEAL_TYPE_ID::NUMBER(38, 0) AS APPEAL_TYPE_ID, 
		$1:AppealTypeDescription::VARCHAR AS AppealTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAppealType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
