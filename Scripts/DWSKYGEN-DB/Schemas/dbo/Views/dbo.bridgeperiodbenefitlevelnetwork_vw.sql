CREATE OR REPLACE VIEW DBO.BridgePeriodBenefitLevelNetwork_VW
AS 
SELECT 	$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgePeriodBenefitLevelNetwork/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);