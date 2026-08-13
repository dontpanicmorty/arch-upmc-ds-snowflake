CREATE OR REPLACE VIEW DBO.DimSQLRule_VW
AS 
SELECT 	$1:SQLRuleKey::NUMBER(38, 0) AS SQLRuleKey, 
		$1:SQL_RULE_ID::NUMBER(38, 0) AS SQL_RULE_ID, 
		$1:SQLDescription::VARCHAR AS SQLDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSQLRule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
