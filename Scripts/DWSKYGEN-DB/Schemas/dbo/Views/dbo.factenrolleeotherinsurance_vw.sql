CREATE OR REPLACE VIEW DBO.FactEnrolleeOtherInsurance_VW
AS 
SELECT 	$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:DateOfCoverageEffectiveKey::NUMBER(38, 0) AS DateOfCoverageEffectiveKey, 
		$1:DateOfCoverageTerminationKey::NUMBER(38, 0) AS DateOfCoverageTerminationKey, 
		$1:OTHER_INSURANCE_ID::NUMBER(38, 0) AS OTHER_INSURANCE_ID, 
		$1:OtherInsurancePlanName::VARCHAR AS OtherInsurancePlanName, 
		$1:ResponsiblityCodeDescription::VARCHAR AS ResponsiblityCodeDescription, 
		$1:NOTES::VARCHAR AS NOTES, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactEnrolleeOtherInsurance/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
