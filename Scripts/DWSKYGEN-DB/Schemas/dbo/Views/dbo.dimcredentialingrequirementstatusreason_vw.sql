CREATE OR REPLACE VIEW DBO.DimCredentialingRequirementStatusReason_VW
AS 
SELECT 	$1:CredentialingRequirementStatusReasonKey::NUMBER(38, 0) AS CredentialingRequirementStatusReasonKey, 
		$1:CREDENTIALING_REQUIREMENT_STATUS_REASON_ID::NUMBER(38, 0) AS CREDENTIALING_REQUIREMENT_STATUS_REASON_ID, 
		$1:CredentialingRequirementStatusReasonDescription::VARCHAR AS CredentialingRequirementStatusReasonDescription, 
		$1:CredentialingRequirementStatus::NUMBER(38, 0) AS CredentialingRequirementStatus, 
		$1:CredentialingRequirementStatusDescription::VARCHAR AS CredentialingRequirementStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCredentialingRequirementStatusReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
