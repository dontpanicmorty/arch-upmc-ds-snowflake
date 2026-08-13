CREATE OR REPLACE VIEW DBO.DimBrokerLicenseType_VW
AS 
SELECT 	$1:BrokerLicenseTypeKey::NUMBER(38, 0) AS BrokerLicenseTypeKey, 
		$1:BROKER_LICENSE_TYPE::NUMBER(38, 0) AS BROKER_LICENSE_TYPE, 
		$1:BrokerLicenseTypeDescription::VARCHAR AS BrokerLicenseTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBrokerLicenseType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
