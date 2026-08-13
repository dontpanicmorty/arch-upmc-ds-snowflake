CREATE OR REPLACE VIEW DBO.BridgeAllowableRuleGroup_VW
AS 
SELECT 	$1:AllowableRuleKey::NUMBER(38, 0) AS AllowableRuleKey, 
		$1:AllowableRuleGroupKey::NUMBER(38, 0) AS AllowableRuleGroupKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeAllowableRuleGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
