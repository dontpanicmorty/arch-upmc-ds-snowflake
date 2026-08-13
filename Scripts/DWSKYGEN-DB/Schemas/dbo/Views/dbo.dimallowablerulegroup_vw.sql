CREATE OR REPLACE VIEW DBO.DimAllowableRuleGroup_VW
AS 
SELECT 	$1:AllowableRuleGroupKey::NUMBER(38, 0) AS AllowableRuleGroupKey, 
		$1:ALLOWABLE_RULE_GROUP::NUMBER(38, 0) AS ALLOWABLE_RULE_GROUP, 
		$1:AllowableRuleGroupDescription::VARCHAR AS AllowableRuleGroupDescription, 
		$1:LesserOfFlag::BOOLEAN AS LesserOfFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAllowableRuleGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
