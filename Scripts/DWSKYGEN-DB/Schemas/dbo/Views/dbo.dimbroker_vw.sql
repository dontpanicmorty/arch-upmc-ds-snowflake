CREATE OR REPLACE VIEW DBO.DimBroker_VW
AS 
SELECT 	$1:BrokerKey::NUMBER(38, 0) AS BrokerKey, 
		$1:BROKER_ID::NUMBER(38, 0) AS BROKER_ID, 
		$1:BrokerFirstName::VARCHAR AS BrokerFirstName, 
		$1:BrokerLastName::VARCHAR AS BrokerLastName, 
		$1:BrokerMiddleName::VARCHAR AS BrokerMiddleName, 
		$1:BrokerTypeID::NUMBER(38, 0) AS BrokerTypeID, 
		$1:BrokerTypeDescription::VARCHAR AS BrokerTypeDescription, 
		$1:BrokerCredentialingID::VARCHAR AS BrokerCredentialingID, 
		$1:BrokerDOB::DATE AS BrokerDOB, 
		$1:BrokerEmail::VARCHAR AS BrokerEmail, 
		$1:BrokerNumber::VARCHAR AS BrokerNumber, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBroker/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
