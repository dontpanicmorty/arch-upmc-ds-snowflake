CREATE OR REPLACE VIEW DBO.DimReimbursementMethod_VW
AS 
SELECT 	$1:ReimbursementMethodKey::NUMBER(38, 0) AS ReimbursementMethodKey, 
		$1:REIMBURSEMENT_METHOD::NUMBER(38, 0) AS REIMBURSEMENT_METHOD, 
		$1:ReimbursementMethodName::VARCHAR AS ReimbursementMethodName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimReimbursementMethod/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
