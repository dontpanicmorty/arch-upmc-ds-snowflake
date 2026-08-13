CREATE OR REPLACE VIEW DBO.BridgeBenefitPlanNetwork_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeBenefitPlanNetwork/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
