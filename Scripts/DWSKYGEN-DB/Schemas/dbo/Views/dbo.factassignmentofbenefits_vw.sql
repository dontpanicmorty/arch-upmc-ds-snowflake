CREATE OR REPLACE VIEW DBO.FactAssignmentOfBenefits_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:PaymentRecipientKey::NUMBER(38, 0) AS PaymentRecipientKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:RecordSourceKey::NUMBER(38, 0) AS RecordSourceKey, 
		$1:StateKey::NUMBER(38, 0) AS StateKey, 
		$1:ASSIGNMENT_OF_BENEFITS_ID::NUMBER(38, 0) AS ASSIGNMENT_OF_BENEFITS_ID, 
		$1:BenefitAssignmentEffectiveDate::DATE AS BenefitAssignmentEffectiveDate, 
		$1:BenefitAssignmentTerminationDate::DATE AS BenefitAssignmentTerminationDate, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactAssignmentOfBenefits/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
