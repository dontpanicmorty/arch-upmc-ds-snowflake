CREATE OR REPLACE VIEW DBO.DimAllowableRule_VW
AS 
SELECT 	$1:AllowableRuleKey::NUMBER(38, 0) AS AllowableRuleKey, 
		$1:ALLOWABLE_RULE::NUMBER(38, 0) AS ALLOWABLE_RULE, 
		$1:AllowableRuleDescription::VARCHAR AS AllowableRuleDescription, 
		$1:AllowableRuleType::NUMBER(38, 0) AS AllowableRuleType, 
		$1:AllowableRuleTypeDescription::VARCHAR AS AllowableRuleTypeDescription, 
		$1:RulePercent::NUMBER(9, 4) AS RulePercent, 
		$1:AdjustmentAmount::NUMBER(19, 4) AS AdjustmentAmount, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAllowableRule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
