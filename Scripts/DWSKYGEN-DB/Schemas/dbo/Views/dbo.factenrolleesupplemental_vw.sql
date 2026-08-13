CREATE OR REPLACE VIEW DBO.FactEnrolleeSupplemental_VW
AS 
SELECT 	$1:EnrolleeSupplementalTypeKey::NUMBER(38, 0) AS EnrolleeSupplementalTypeKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:EnrolleeSupplementalID::NUMBER(38, 0) AS EnrolleeSupplementalID, 
		$1:EnrolleeSupplementalName::VARCHAR AS EnrolleeSupplementalName, 
		$1:EnrolleeSupplementalValue::VARCHAR AS EnrolleeSupplementalValue, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactEnrolleeSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
