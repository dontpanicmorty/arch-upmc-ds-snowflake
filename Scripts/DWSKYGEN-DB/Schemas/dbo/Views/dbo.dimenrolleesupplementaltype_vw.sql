CREATE OR REPLACE VIEW DBO.DimEnrolleeSupplementalType_VW
AS 
SELECT 	$1:EnrolleeSupplementalTypeKey::NUMBER(38, 0) AS EnrolleeSupplementalTypeKey, 
		$1:ENROLLEE_SUPPLEMENTAL_TYPE::NUMBER(38, 0) AS ENROLLEE_SUPPLEMENTAL_TYPE, 
		$1:EnrolleeSupplementalTypeDescription::VARCHAR AS EnrolleeSupplementalTypeDescription, 
		$1:ProductRequiredFlag::BOOLEAN AS ProductRequiredFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimEnrolleeSupplementalType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
