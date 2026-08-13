CREATE OR REPLACE VIEW DBO.DimPremiumGroupBillingCriteria_VW
AS 
SELECT 	$1:PremiumGroupBillingCriteriaKey::NUMBER(38, 0) AS PremiumGroupBillingCriteriaKey, 
		$1:PREMIUM_GROUP_ID::NUMBER(38, 0) AS PREMIUM_GROUP_ID, 
		$1:PRODUCT_ID::NUMBER(38, 0) AS PRODUCT_ID, 
		$1:IDCardFormatID::NUMBER(38, 0) AS IDCardFormatID, 
		$1:IDCardFormatDescription::VARCHAR AS IDCardFormatDescription, 
		$1:PartialMonthPremiumFormula::NUMBER(38, 0) AS PartialMonthPremiumFormula, 
		$1:PartialMonthPremiumFormulaDescription::VARCHAR AS PartialMonthPremiumFormulaDescription, 
		$1:PrimaryLogoCode::VARCHAR AS PrimaryLogoCode, 
		$1:ClientLogoCode::VARCHAR AS ClientLogoCode, 
		$1:RenewalInterval::NUMBER(38, 0) AS RenewalInterval, 
		$1:ClaimsAdminFeePercentage::NUMBER(19, 4) AS ClaimsAdminFeePercentage, 
		$1:ClaimsAdminFeeAmount::NUMBER(19, 4) AS ClaimsAdminFeeAmount, 
		$1:ClaimsAdminFeeTypeID::NUMBER(38, 0) AS ClaimsAdminFeeTypeID, 
		$1:ClaimsAdminFeeTypeDescription::VARCHAR AS ClaimsAdminFeeTypeDescription, 
		$1:PremiumsFlag::BOOLEAN AS PremiumsFlag, 
		$1:ClaimsFlag::BOOLEAN AS ClaimsFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPremiumGroupBillingCriteria/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
