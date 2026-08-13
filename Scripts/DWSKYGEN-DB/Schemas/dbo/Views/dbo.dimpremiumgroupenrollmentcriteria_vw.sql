CREATE OR REPLACE VIEW DBO.DimPremiumGroupEnrollmentCriteria_VW
AS 
SELECT 	$1:PremiumGroupEnrollmentCriteriaKey::NUMBER(38, 0) AS PremiumGroupEnrollmentCriteriaKey, 
		$1:PREMIUM_GROUP_ID::NUMBER(38, 0) AS PREMIUM_GROUP_ID, 
		$1:PRODUCT_ID::NUMBER(38, 0) AS PRODUCT_ID, 
		$1:EnrollmentEligibilityRule::NUMBER(38, 0) AS EnrollmentEligibilityRule, 
		$1:EnrollmentEligibilityRuleDescription::VARCHAR AS EnrollmentEligibilityRuleDescription, 
		$1:EnrollmentEligibilityLength::NUMBER(38, 0) AS EnrollmentEligibilityLength, 
		$1:EnrollmentEligibilityTimeSpan::VARCHAR AS EnrollmentEligibilityTimeSpan, 
		$1:TerminationEligibilityRule::NUMBER(38, 0) AS TerminationEligibilityRule, 
		$1:TerminationEligibilityRuleDescription::VARCHAR AS TerminationEligibilityRuleDescription, 
		$1:TerminationEligibilityLength::NUMBER(38, 0) AS TerminationEligibilityLength, 
		$1:TerminationEligibilityTimespan::VARCHAR AS TerminationEligibilityTimespan, 
		$1:OpenEnrollmentBeginDay::NUMBER(38, 0) AS OpenEnrollmentBeginDay, 
		$1:OpenEnrollmentBeginMonth::NUMBER(38, 0) AS OpenEnrollmentBeginMonth, 
		$1:OpenEnrollmentEndDay::NUMBER(38, 0) AS OpenEnrollmentEndDay, 
		$1:OpenEnrollmentEndMonth::NUMBER(38, 0) AS OpenEnrollmentEndMonth, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPremiumGroupEnrollmentCriteria/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
