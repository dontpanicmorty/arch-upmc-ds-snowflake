CREATE OR REPLACE VIEW DBO.RefEnrolleePHIAccess_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateExpirationKey::NUMBER(38, 0) AS DateExpirationKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:PHIAccessTypeKey::NUMBER(38, 0) AS PHIAccessTypeKey, 
		$1:PHIRelationshipCodeKey::NUMBER(38, 0) AS PHIRelationshipCodeKey, 
		$1:ENROLLEE_PHI_ID::NUMBER(38, 0) AS ENROLLEE_PHI_ID, 
		$1:PHIName::VARCHAR AS PHIName, 
		$1:PHINotes::VARCHAR AS PHINotes, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/RefEnrolleePHIAccess/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
