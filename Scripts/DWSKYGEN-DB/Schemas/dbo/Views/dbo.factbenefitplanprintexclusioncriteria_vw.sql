CREATE OR REPLACE VIEW DBO.FactBenefitPlanPrintExclusionCriteria_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:PrintExclusionCriteriaKey::NUMBER(38, 0) AS PrintExclusionCriteriaKey, 
		$1:CodesetKey::NUMBER(38, 0) AS CodesetKey, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactBenefitPlanPrintExclusionCriteria/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
