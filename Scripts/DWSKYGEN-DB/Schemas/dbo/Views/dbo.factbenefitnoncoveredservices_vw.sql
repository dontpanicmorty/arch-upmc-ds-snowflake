CREATE OR REPLACE VIEW DBO.FactBenefitNonCoveredServices_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:AlternateCodeKey::NUMBER(38, 0) AS AlternateCodeKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:SubCodeKey::NUMBER(38, 0) AS SubCodeKey, 
		$1:AGE_MIN::NUMBER(38, 0) AS AGE_MIN, 
		$1:AGE_MAX::NUMBER(38, 0) AS AGE_MAX, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBenefitNonCoveredServices/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

