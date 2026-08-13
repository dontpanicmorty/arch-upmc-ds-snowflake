CREATE OR REPLACE VIEW DBO.FactReimbursementScheduleDetail_VW
AS 
SELECT 	$1:AllowableRuleGroupKey::NUMBER(38, 0) AS AllowableRuleGroupKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:PlaceOfServiceTypeKey::NUMBER(38, 0) AS PlaceOfServiceTypeKey, 
		$1:ReimbursementMethodKey::NUMBER(38, 0) AS ReimbursementMethodKey, 
		$1:ReimbursementScheduleKey::NUMBER(38, 0) AS ReimbursementScheduleKey, 
		$1:SubcodeKey::NUMBER(38, 0) AS SubcodeKey, 
		$1:UNITS_FROM::NUMBER(38, 0) AS UNITS_FROM, 
		$1:UNITS_TO::NUMBER(38, 0) AS UNITS_TO, 
		$1:ADDTL_COMP_ALLOWABLE_RULE_GROUP::NUMBER(38, 0) AS ADDTL_COMP_ALLOWABLE_RULE_GROUP, 
		$1:APPLY_ALLOWABLE_PERCENT_FLAG::BOOLEAN AS APPLY_ALLOWABLE_PERCENT_FLAG, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactReimbursementScheduleDetail/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
