CREATE OR REPLACE VIEW DBO.FactServiceDocumentRequirements_VW
AS 
SELECT 	$1:BenefitLevelKey::NUMBER(38, 0) AS BenefitLevelKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:BenefitPlanPeriodKey::NUMBER(38, 0) AS BenefitPlanPeriodKey, 
		$1:CodesetKey::NUMBER(38, 0) AS CodesetKey, 
		$1:DateCreateKey::NUMBER(38, 0) AS DateCreateKey, 
		$1:DenialExceptionCodeKey::NUMBER(38, 0) AS DenialExceptionCodeKey, 
		$1:DocumentTypesFlagKey::NUMBER(38, 0) AS DocumentTypesFlagKey, 
		$1:MatchExceptionCodeKey::NUMBER(38, 0) AS MatchExceptionCodeKey, 
		$1:ServiceDocumentTypeKey::NUMBER(38, 0) AS ServiceDocumentTypeKey, 
		$1:SubcodeGroupKey::NUMBER(38, 0) AS SubcodeGroupKey, 
		$1:SERVICE_DOCUMENT_REQUIREMENT_ID::NUMBER(38, 0) AS SERVICE_DOCUMENT_REQUIREMENT_ID, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactServiceDocumentRequirements/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
