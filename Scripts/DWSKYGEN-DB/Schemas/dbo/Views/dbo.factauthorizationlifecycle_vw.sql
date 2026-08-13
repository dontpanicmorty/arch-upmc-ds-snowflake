CREATE OR REPLACE VIEW DBO.FactAuthorizationLifeCycle_VW
AS 
SELECT 	$1:DateDeterminationKey::NUMBER(38, 0) AS DateDeterminationKey, 
		$1:DateReceivedKey::NUMBER(38, 0) AS DateReceivedKey, 
		$1:DeterminationReasonKey::NUMBER(38, 0) AS DeterminationReasonKey, 
		$1:DeterminationStateKey::NUMBER(38, 0) AS DeterminationStateKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:AUTHORIZATION_ID::NUMBER(38, 0) AS AUTHORIZATION_ID, 
		$1:ITEM_NUMBER::NUMBER(38, 0) AS ITEM_NUMBER, 
		$1:LOG_ID::NUMBER(38, 0) AS LOG_ID, 
		$1:DeterminationLifeCycleMessage::VARCHAR AS DeterminationLifeCycleMessage, 
		$1:CreationDate::TIMESTAMP_NTZ AS CreationDate, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactAuthorizationLifeCycle/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
