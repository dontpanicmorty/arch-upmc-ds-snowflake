CREATE OR REPLACE VIEW DBO.DimBusinessType_VW
AS 
SELECT 	$1:BusinessTypeKey::NUMBER(38, 0) AS BusinessTypeKey, 
		$1:BUSINESS_TYPE_ID::NUMBER(38, 0) AS BUSINESS_TYPE_ID, 
		$1:BusinessTypeDescription::VARCHAR AS BusinessTypeDescription, 
		$1:BusinessCategoryID::NUMBER(38, 0) AS BusinessCategoryID, 
		$1:BusinessCategoryDescription::VARCHAR AS BusinessCategoryDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBusinessType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
