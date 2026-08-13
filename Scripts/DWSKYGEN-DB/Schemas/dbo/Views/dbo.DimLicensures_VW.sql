CREATE OR REPLACE VIEW DBO.DimLicensures_VW
AS 
SELECT 	$1:LicensureKey::NUMBER(38, 0) AS LicensureKey, 
		$1:LICENSURE_ID::NUMBER(38, 0) AS LICENSURE_ID, 
		$1:Abbreviation::VARCHAR AS Abbreviation, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimLicensures/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
