CREATE OR REPLACE VIEW DBO.BridgeCheckBenefitPlan_VW
AS 
SELECT 	$1:CheckKey::NUMBER(38, 0) AS CheckKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeCheckBenefitPlan/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
