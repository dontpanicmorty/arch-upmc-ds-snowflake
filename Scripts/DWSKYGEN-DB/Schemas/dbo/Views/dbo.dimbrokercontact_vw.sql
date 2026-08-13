CREATE OR REPLACE VIEW DBO.DimBrokerContact_VW
AS 
SELECT 	$1:BrokerContactKey::NUMBER(38, 0) AS BrokerContactKey, 
		$1:BROKER_CONTACT_ID::NUMBER(38, 0) AS BROKER_CONTACT_ID, 
		$1:ContactName::VARCHAR AS ContactName, 
		$1:BrokerContactAddress1::VARCHAR AS BrokerContactAddress1, 
		$1:BrokerContactAddress2::VARCHAR AS BrokerContactAddress2, 
		$1:BrokerContactCity::VARCHAR AS BrokerContactCity, 
		$1:BrokerContactState::VARCHAR AS BrokerContactState, 
		$1:BrokerContactZip::VARCHAR AS BrokerContactZip, 
		$1:BrokerContactZip4::VARCHAR AS BrokerContactZip4, 
		$1:BrokerContactEmail::VARCHAR AS BrokerContactEmail, 
		$1:BrokerContactOfficePhone::VARCHAR AS BrokerContactOfficePhone, 
		$1:BrokerContactCellPhone::VARCHAR AS BrokerContactCellPhone, 
		$1:BrokerContactFaxPhone::VARCHAR AS BrokerContactFaxPhone, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerContact/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
