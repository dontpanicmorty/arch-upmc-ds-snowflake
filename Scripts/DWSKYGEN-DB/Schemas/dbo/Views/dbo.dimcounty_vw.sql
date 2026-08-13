CREATE OR REPLACE VIEW DBO.DimCounty_VW
AS 
SELECT 	$1:CountyKey::NUMBER(38, 0) AS CountyKey, 
		$1:COUNTY_ID::NUMBER(38, 0) AS COUNTY_ID, 
		$1:CountyName::VARCHAR AS CountyName, 
		$1:State::VARCHAR AS State, 
		$1:StateName::VARCHAR AS StateName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCounty/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
