CREATE OR REPLACE VIEW DBO.FactCodeSwitches_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:SubcodeKey::NUMBER(38, 0) AS SubcodeKey, 
		$1:NewSubcodeKey::NUMBER(38, 0) AS NewSubcodeKey, 
		$1:NewCodeKey::NUMBER(38, 0) AS NewCodeKey, 
		$1:AgeMinKey::NUMBER(38, 0) AS AgeMinKey, 
		$1:AgeMaxKey::NUMBER(38, 0) AS AgeMaxKey, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactCodeSwitches/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
