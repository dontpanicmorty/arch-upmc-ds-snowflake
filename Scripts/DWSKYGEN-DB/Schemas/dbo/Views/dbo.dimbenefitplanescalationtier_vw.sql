CREATE OR REPLACE VIEW DBO.DimBenefitPlanEscalationTier_VW
AS 
SELECT 	$1:BenefitPlanEscalationTierKey::NUMBER(38, 0) AS BenefitPlanEscalationTierKey, 
		$1:PRODUCT_ID::NUMBER(38, 0) AS PRODUCT_ID, 
		$1:BENEFIT_LEVEL_ESCALATION::NUMBER(38, 0) AS BENEFIT_LEVEL_ESCALATION, 
		$1:BenefitEscalationTierDescription::VARCHAR AS BenefitEscalationTierDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBenefitPlanEscalationTier/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
