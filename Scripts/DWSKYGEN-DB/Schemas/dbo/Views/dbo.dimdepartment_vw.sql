CREATE OR REPLACE VIEW DBO.DimDepartment_VW
AS 
SELECT 	$1:DepartmentKey::NUMBER(38, 0) AS DepartmentKey, 
		$1:DEPARTMENT_ID::NUMBER(38, 0) AS DEPARTMENT_ID, 
		$1:DepartmentName::VARCHAR AS DepartmentName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDepartment/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
