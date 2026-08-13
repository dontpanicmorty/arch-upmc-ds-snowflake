CREATE OR REPLACE VIEW DBO.FactClaimResolutions_VW
AS 
SELECT 	$1:DenialCodeKey::NUMBER(38, 0) AS DenialCodeKey, 
		$1:CLAIM_ID::NUMBER(38, 0) AS CLAIM_ID, 
		$1:EXCEPTION_NUMBER::NUMBER(38, 0) AS EXCEPTION_NUMBER, 
		$1:ExceptionDetails::VARCHAR AS ExceptionDetails, 
		$1:ResolutionInfo::VARCHAR AS ResolutionInfo, 
		$1:ApprovalReasonCodeKey::NUMBER(38, 0) AS ApprovalReasonCodeKey, 
		$1:ApprovalDomainSourceKey::NUMBER(38, 0) AS ApprovalDomainSourceKey, 
		$1:DateApprovalCreationKey::NUMBER(38, 0) AS DateApprovalCreationKey, 
		$1:ApprovalNotes::VARCHAR AS ApprovalNotes, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactClaimResolutions/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
