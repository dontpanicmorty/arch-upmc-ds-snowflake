CREATE OR REPLACE VIEW DBO.DimModule_VW
AS 
SELECT 	$1:ModuleKey::NUMBER(38, 0) AS ModuleKey, 
		$1:MODULE_ID::NUMBER(38, 0) AS MODULE_ID, 
		$1:ModuleDescription::VARCHAR AS ModuleDescription, 
		$1:ModuleShortDescription::VARCHAR AS ModuleShortDescription, 
		$1:CategoryID::NUMBER(38, 0) AS CategoryID, 
		$1:CategoryDescription::VARCHAR AS CategoryDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimModule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
