CREATE OR REPLACE VIEW DBO.DimNetwork_VW
AS 
SELECT 	$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:NETWORK_ID::NUMBER(38, 0) AS NETWORK_ID, 
		$1:Name::VARCHAR AS Name, 
		$1:ReimbursementPriority::NUMBER(38,0) AS ReimbursementPriority, 
		$1:CLIENT_NETWORK_ID::VARCHAR AS CLIENT_NETWORK_ID, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimNetwork/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
