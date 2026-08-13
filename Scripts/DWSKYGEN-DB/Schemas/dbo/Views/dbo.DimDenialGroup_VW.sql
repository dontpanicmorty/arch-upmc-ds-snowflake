CREATE OR REPLACE VIEW DBO.DimDenialGroup_VW
AS 
SELECT 	$1:DenialGroupKey::NUMBER(38, 0) AS DenialGroupKey, 
		$1:DenialLevel::VARCHAR AS DenialLevel, 
		$1:DenialGroupListing::VARCHAR AS DenialGroupListing, 
		$1:DenialGroupDescription::VARCHAR AS DenialGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDenialGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
