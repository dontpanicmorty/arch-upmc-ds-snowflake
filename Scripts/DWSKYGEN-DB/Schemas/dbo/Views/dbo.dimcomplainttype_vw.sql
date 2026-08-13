CREATE OR REPLACE VIEW DBO.DimComplaintType_VW
AS 
SELECT 	$1:ComplaintTypeKey::NUMBER(38, 0) AS ComplaintTypeKey, 
		$1:COMPLAINT_TYPE_ID::NUMBER(38, 0) AS COMPLAINT_TYPE_ID, 
		$1:ComplaintTypeDescription::VARCHAR AS ComplaintTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimComplaintType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
