CREATE OR REPLACE VIEW DBO.FactProductGuidelines_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:AuthorizationGuidelineKey::NUMBER(38, 0) AS AuthorizationGuidelineKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:AgeMinKey::NUMBER(38, 0) AS AgeMinKey, 
		$1:AgeMaxKey::NUMBER(38, 0) AS AgeMaxKey, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactProductGuidelines/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
