CREATE OR REPLACE VIEW DBO.FactClaimWorkQueue_VW
AS 
SELECT 	$1:AssignedToKey::NUMBER(38, 0) AS AssignedToKey, 
		$1:ReleaseByKey::NUMBER(38, 0) AS ReleaseByKey, 
		$1:WorkQueueKey::NUMBER(38, 0) AS WorkQueueKey, 
		$1:CLAIM_ID::NUMBER(38, 0) AS CLAIM_ID, 
		$1:DATE_IN_QUEUE::TIMESTAMP_NTZ AS DATE_IN_QUEUE, 
		$1:DATE_OUT_OF_QUEUE::TIMESTAMP_NTZ AS DATE_OUT_OF_QUEUE, 
		$1:LastDateInQueue::TIMESTAMP_NTZ AS LastDateInQueue, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactClaimWorkQueue/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
