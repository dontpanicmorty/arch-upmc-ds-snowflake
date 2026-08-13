CREATE OR REPLACE VIEW DBO.DimBillingAttribute_VW
AS 
SELECT 	$1:BillingAttributeKey::NUMBER(38, 0) AS BillingAttributeKey, 
		$1:GROUP_BENEFIT_FUNDING_METHOD_ID::NUMBER(38, 0) AS GROUP_BENEFIT_FUNDING_METHOD_ID, 
		$1:GroupBenefitFundingMethodDescription::VARCHAR AS GroupBenefitFundingMethodDescription, 
		$1:GroupBenefitFundingTypeID::NUMBER(38, 0) AS GroupBenefitFundingTypeID, 
		$1:GroupBenefitFundingTypeDescription::VARCHAR AS GroupBenefitFundingTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBillingAttribute/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
