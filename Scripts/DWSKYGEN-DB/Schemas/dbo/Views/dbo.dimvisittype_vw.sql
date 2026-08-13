CREATE OR REPLACE VIEW DBO.DimVisitType_VW
AS 
SELECT 	$1:VisitTypeKey::NUMBER(38, 0) AS VisitTypeKey, 
		$1:VISIT_TYPE::NUMBER(38, 0) AS VISIT_TYPE, 
		$1:VisitTypeDescription::VARCHAR AS VisitTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVisitType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
