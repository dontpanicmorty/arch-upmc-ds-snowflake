CREATE OR REPLACE VIEW DBO.DimCheckingAccount_VW
AS 
SELECT 	$1:CheckingAccountKey::NUMBER(38, 0) AS CheckingAccountKey, 
		$1:BANK_ID::NUMBER(38, 0) AS BANK_ID, 
		$1:CHECKING_ACCOUNT::VARCHAR AS CHECKING_ACCOUNT, 
		$1:BankName::VARCHAR AS BankName, 
		$1:BankAddress::VARCHAR AS BankAddress, 
		$1:BankAddress2::VARCHAR AS BankAddress2, 
		$1:BankCity::VARCHAR AS BankCity, 
		$1:BankState::VARCHAR AS BankState, 
		$1:BankZip::VARCHAR AS BankZip, 
		$1:BankZip4::VARCHAR AS BankZip4, 
		$1:CheckingAccountName::VARCHAR AS CheckingAccountName, 
		$1:EffectiveDate::DATE AS EffectiveDate, 
		$1:TerminationDate::DATE AS TerminationDate, 
		$1:RoutingNumber::VARCHAR AS RoutingNumber, 
		$1:PhoneNumber::VARCHAR AS PhoneNumber, 
		$1:FaxPhoneNumber::VARCHAR AS FaxPhoneNumber, 
		$1:ACHRoutingNumber::VARCHAR AS ACHRoutingNumber, 
		$1:ACHProcessorName::VARCHAR AS ACHProcessorName, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCheckingAccount/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
