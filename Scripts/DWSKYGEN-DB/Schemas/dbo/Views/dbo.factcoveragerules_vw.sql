CREATE OR REPLACE VIEW DBO.FactCoverageRules_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:SQLRuleKey::NUMBER(38, 0) AS SQLRuleKey, 
		$1:CoveredFlagKey::NUMBER(38, 0) AS CoveredFlagKey, 
		$1:SEQUENCE_NUMBER::NUMBER(38, 0) AS SEQUENCE_NUMBER, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactCoverageRules/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
