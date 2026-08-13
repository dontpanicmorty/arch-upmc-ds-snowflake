CREATE OR REPLACE VIEW DBO.DimCredentialingSanctionReason_VW
AS 
SELECT 	$1:CredentialingSanctionReasonKey::NUMBER(38, 0) AS CredentialingSanctionReasonKey, 
		$1:CREDENTIALING_SANCTION_REASON_ID::NUMBER(38, 0) AS CREDENTIALING_SANCTION_REASON_ID, 
		$1:CredentialingSanctionReasonDescription::VARCHAR AS CredentialingSanctionReasonDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingSanctionReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
