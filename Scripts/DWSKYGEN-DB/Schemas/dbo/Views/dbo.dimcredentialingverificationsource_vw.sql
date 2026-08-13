CREATE OR REPLACE VIEW DBO.DimCredentialingVerificationSource_VW
AS 
SELECT 	$1:CredentialingVerificationSourceKey::NUMBER(38, 0) AS CredentialingVerificationSourceKey, 
		$1:CREDENTIALING_VERIFICATION_SOURCE_ID::NUMBER(38, 0) AS CREDENTIALING_VERIFICATION_SOURCE_ID, 
		$1:CredentialingVerificationSourceDescription::VARCHAR AS CredentialingVerificationSourceDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingVerificationSource/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
