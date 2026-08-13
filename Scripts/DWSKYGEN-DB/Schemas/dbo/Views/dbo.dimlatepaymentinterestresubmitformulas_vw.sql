CREATE OR REPLACE VIEW DBO.DimLatePaymentInterestResubmitFormulas_VW
AS 
SELECT 	$1:LatePaymentInterestResubmitFormulaKey::NUMBER(38, 0) AS LatePaymentInterestResubmitFormulaKey, 
		$1:LATE_PAYMENT_INTEREST_RESUBMIT_FORMULA::NUMBER(38, 0) AS LATE_PAYMENT_INTEREST_RESUBMIT_FORMULA, 
		$1:LatePaymentInterestResubmitFormulaDescription::VARCHAR AS LatePaymentInterestResubmitFormulaDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimLatePaymentInterestResubmitFormulas/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
