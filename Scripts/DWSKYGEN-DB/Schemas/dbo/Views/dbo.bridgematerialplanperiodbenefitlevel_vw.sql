CREATE OR REPLACE VIEW DBO.BridgeMaterialPlanPeriodBenefitLevel_VW
AS 
SELECT 	$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:MaterialPlanKey::NUMBER(38, 0) AS MaterialPlanKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeMaterialPlanPeriodBenefitLevel/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);