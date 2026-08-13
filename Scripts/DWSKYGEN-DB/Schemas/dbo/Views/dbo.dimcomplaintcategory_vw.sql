CREATE OR REPLACE VIEW DBO.DimComplaintCategory_VW
AS 
SELECT 	$1:ComplaintCategoryKey::NUMBER(38, 0) AS ComplaintCategoryKey, 
		$1:COMPLAINT_CATEGORY_ID::NUMBER(38, 0) AS COMPLAINT_CATEGORY_ID, 
		$1:ComplaintCategoryDescription::VARCHAR AS ComplaintCategoryDescription, 
		$1:ComplaintTypeID::NUMBER(38, 0) AS ComplaintTypeID, 
		$1:ComplaintTypeDescription::VARCHAR AS ComplaintTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimComplaintCategory/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
