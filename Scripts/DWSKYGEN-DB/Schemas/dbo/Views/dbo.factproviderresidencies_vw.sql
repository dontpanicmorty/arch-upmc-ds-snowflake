CREATE OR REPLACE VIEW DBO.FactProviderResidencies_VW
AS 
SELECT 	$1:CredentialingTrainingTypeKey::NUMBER(38, 0) AS CredentialingTrainingTypeKey, 
		$1:DateCompletionKey::NUMBER(38, 0) AS DateCompletionKey, 
		$1:DateStartKey::NUMBER(38, 0) AS DateStartKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:SpecialtyKey::NUMBER(38, 0) AS SpecialtyKey, 
		$1:PROVIDER_RESIDENCY_ID::NUMBER(38, 0) AS PROVIDER_RESIDENCY_ID, 
		$1:TRAINING_NAME::VARCHAR AS TRAINING_NAME, 
		$1:DEPARTMENT_NAME::VARCHAR AS DEPARTMENT_NAME, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactProviderResidencies/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
