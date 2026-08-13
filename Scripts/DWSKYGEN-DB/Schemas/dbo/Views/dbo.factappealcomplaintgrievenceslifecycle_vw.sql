CREATE OR REPLACE VIEW DBO.FactAppealComplaintGrievencesLifeCycle_VW
AS 
SELECT 	$1:DateCreationKey::NUMBER(38, 0) AS DateCreationKey, 
		$1:DateReceivedKey::NUMBER(38, 0) AS DateReceivedKey, 
		$1:DateResolvedKey::NUMBER(38, 0) AS DateResolvedKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:LOG_ID::NUMBER(38, 0) AS LOG_ID, 
		$1:APPEAL_ID::NUMBER(38, 0) AS APPEAL_ID, 
		$1:APPEAL_NUMBER::VARCHAR AS APPEAL_NUMBER, 
		$1:CREATION_DATE::TIMESTAMP_NTZ AS CREATION_DATE, 
		$1:MESSAGE::VARCHAR AS MESSAGE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactAppealComplaintGrievencesLifeCycle/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
