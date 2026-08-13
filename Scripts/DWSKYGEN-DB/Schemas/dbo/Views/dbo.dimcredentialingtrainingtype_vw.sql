CREATE OR REPLACE VIEW DBO.DimCredentialingTrainingType_VW
AS 
SELECT 	$1:CredentialingTrainingTypeKey::NUMBER(38, 0) AS CredentialingTrainingTypeKey, 
		$1:TRAINING_TYPE::NUMBER(38, 0) AS TRAINING_TYPE, 
		$1:CredentialingTrainingTypeDescription::VARCHAR AS CredentialingTrainingTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingTrainingType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
