CREATE OR REPLACE VIEW DBO.DimClaimStatus_VW
AS 
SELECT 	$1:ClaimStatusKey::NUMBER(38, 0) AS ClaimStatusKey, 
		$1:CLAIM_STATUS::NUMBER(38, 0) AS CLAIM_STATUS, 
		$1:ClaimStatusDescription::VARCHAR AS ClaimStatusDescription, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		$1:RecordStartDate::DATE AS RecordStartDate
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimClaimStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
