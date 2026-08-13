CREATE OR REPLACE VIEW DBO.DimProviderMalpracticeInsurance_VW
AS 
SELECT 	$1:ProviderMalpracticeInsuranceKey::NUMBER(38, 0) AS ProviderMalpracticeInsuranceKey, 
		$1:PROVIDER_ID::NUMBER(38, 0) AS PROVIDER_ID, 
		$1:InsuranceCarrierName::VARCHAR AS InsuranceCarrierName, 
		$1:PolicyHolderName::VARCHAR AS PolicyHolderName, 
		$1:MalpracticeInsurancePolicyType::NUMBER(38, 0) AS MalpracticeInsurancePolicyType, 
		$1:MalpracticeInsurancePolicyTypeDescription::VARCHAR AS MalpracticeInsurancePolicyTypeDescription, 
		$1:CoverageLimitPerClaim::NUMBER(19, 4) AS CoverageLimitPerClaim, 
		$1:CoverageLimitAggregate::NUMBER(19, 4) AS CoverageLimitAggregate, 
		$1:ExpirationDate::DATE AS ExpirationDate, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProviderMalpracticeInsurance/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
