CREATE OR REPLACE VIEW DBO.DimDiagnosisGroup_VW
AS 
SELECT 	$1:DiagnosisGroupKey::NUMBER(38, 0) AS DiagnosisGroupKey, 
		$1:DiagnosisLevel::VARCHAR AS DiagnosisLevel, 
		$1:DiagnosisGroupListing::VARCHAR AS DiagnosisGroupListing, 
		$1:DiagnosisGroupDescription::VARCHAR AS DiagnosisGroupDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDiagnosisGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
