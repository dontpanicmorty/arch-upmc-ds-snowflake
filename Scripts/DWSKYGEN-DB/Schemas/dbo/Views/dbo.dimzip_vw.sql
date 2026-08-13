CREATE OR REPLACE VIEW DBO.DimZip_VW
AS 
SELECT 	$1:ZipKey::NUMBER(38, 0) AS ZipKey, 
		$1:Zip::VARCHAR AS Zip, 
		$1:Geodesy::VARCHAR AS Geodesy, 
		$1:CountyID::NUMBER(38, 0) AS CountyID, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimZip/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
