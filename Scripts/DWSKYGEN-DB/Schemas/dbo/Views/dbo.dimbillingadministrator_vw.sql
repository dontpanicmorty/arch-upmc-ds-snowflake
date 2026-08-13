CREATE OR REPLACE VIEW DBO.DimBillingAdministrator_VW
AS 
SELECT 	$1:BillingAdministratorKey::NUMBER(38, 0) AS BillingAdministratorKey, 
		$1:BILLING_ADMINISTRATOR_ID::NUMBER(38, 0) AS BILLING_ADMINISTRATOR_ID, 
		$1:BillingAdministratorName::VARCHAR AS BillingAdministratorName, 
		$1:BillingAdministratorNumber::VARCHAR AS BillingAdministratorNumber, 
		$1:BillingAdministratorEmail::VARCHAR AS BillingAdministratorEmail, 
		$1:BillingAdministratorWebPhone::VARCHAR AS BillingAdministratorWebPhone, 
		$1:BillingAdministratorWebURL::VARCHAR AS BillingAdministratorWebURL, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBillingAdministrator/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
