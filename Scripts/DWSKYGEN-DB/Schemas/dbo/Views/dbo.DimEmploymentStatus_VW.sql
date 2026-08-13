CREATE OR REPLACE VIEW DBO.DimEmploymentStatus_VW
AS 
SELECT 	$1:EmploymentStatusKey::NUMBER(38, 0) AS EmploymentStatusKey, 
		$1:EMPLOYMENT_STATUS::VARCHAR AS EMPLOYMENT_STATUS, 
		$1:EmploymentStatusDescription::VARCHAR AS EmploymentStatusDescription, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime,
        $1:RecordStartDate::DATE AS RecordStartDate
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimEmploymentStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);