CREATE OR REPLACE VIEW DBO.BridgeDomainSourceBenefitPlan_VW
AS 
SELECT 	$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeDomainSourceBenefitPlan/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);