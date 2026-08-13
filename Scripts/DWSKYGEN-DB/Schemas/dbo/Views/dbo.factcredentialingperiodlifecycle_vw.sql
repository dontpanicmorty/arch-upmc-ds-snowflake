CREATE OR REPLACE VIEW DBO.FactCredentialingPeriodLifeCycle_VW
AS 
SELECT 	$1:DateApplicationReceivedKey::NUMBER(38, 0) AS DateApplicationReceivedKey, 
		$1:DateCreationKey::NUMBER(38, 0) AS DateCreationKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:CREATION_DATE::TIMESTAMP_NTZ AS CREATION_DATE, 
		$1:LOG_ID::NUMBER(38, 0) AS LOG_ID, 
		$1:PROVIDER_CREDENTIALING_PERIOD_ID::NUMBER(38, 0) AS PROVIDER_CREDENTIALING_PERIOD_ID, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactCredentialingPeriodLifeCycle/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);