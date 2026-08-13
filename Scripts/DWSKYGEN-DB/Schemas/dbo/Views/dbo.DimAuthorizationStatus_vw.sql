CREATE OR REPLACE VIEW DBO.DimAuthorizationStatus_VW
AS 
SELECT 	$1:AuthorizationStatusKey::NUMBER(38, 0) AS AuthorizationStatusKey, 
		$1:AUTHORIZATION_CONSUMPTION_STATUS::NUMBER(38, 0) AS AUTHORIZATION_CONSUMPTION_STATUS, 
		$1:AuthorizationConsumptionDescription::VARCHAR AS AuthorizationConsumptionDescription, 
		$1:AUTHORIZATION_EXPIRATION_STATUS::NUMBER(38, 0) AS AUTHORIZATION_EXPIRATION_STATUS, 
		$1:AuthorizationExpirationDescription::VARCHAR AS AuthorizationExpirationDescription, 
		$1:AUTHORIZATION_PRIORITY_STATUS::NUMBER(38, 0) AS AUTHORIZATION_PRIORITY_STATUS, 
		$1:AuthorizationPriorityDescription::VARCHAR AS AuthorizationPriorityDescription, 
		$1:AUTHORIZATION_STATUS::NUMBER(38, 0) AS AUTHORIZATION_STATUS, 
		$1:AuthorizationStatusDescription::VARCHAR AS AuthorizationStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
