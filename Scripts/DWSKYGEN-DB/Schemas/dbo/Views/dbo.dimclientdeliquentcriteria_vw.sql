CREATE OR REPLACE VIEW DBO.DimClientDeliquentCriteria_VW
AS 
SELECT 	$1:ClientDeliquentCriteriaKey::NUMBER(38, 0) AS ClientDeliquentCriteriaKey, 
		$1:INTEREST_RATE_FORMULA::NUMBER(38, 0) AS INTEREST_RATE_FORMULA, 
		$1:InterestRateFormulaDescription::VARCHAR AS InterestRateFormulaDescription, 
		$1:LATE_FEE_FORMULA::NUMBER(38, 0) AS LATE_FEE_FORMULA, 
		$1:LateFeeFormulaDescription::VARCHAR AS LateFeeFormulaDescription, 
		$1:LATE_PAYMENT_FORMULA::NUMBER(38, 0) AS LATE_PAYMENT_FORMULA, 
		$1:LatePaymentFormulaDescription::VARCHAR AS LatePaymentFormulaDescription, 
		$1:PREMIUM_DUE_DATE_FORMULA::NUMBER(38, 0) AS PREMIUM_DUE_DATE_FORMULA, 
		$1:PremiumDueDateFormulaDescription::VARCHAR AS PremiumDueDateFormulaDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimClientDeliquentCriteria/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
