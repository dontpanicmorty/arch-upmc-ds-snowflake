CREATE OR REPLACE VIEW DBO.FactFollowupLifeCycle_VW
AS 
SELECT 	$1:DepartmentKey::NUMBER(38, 0) AS DepartmentKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:EmployeeKey::NUMBER(38, 0) AS EmployeeKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:FollowUpStatusKey::NUMBER(38, 0) AS FollowUpStatusKey, 
		$1:InquiryTypeKey::NUMBER(38, 0) AS InquiryTypeKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:FOLLOWUP_ID::NUMBER(38, 0) AS FOLLOWUP_ID, 
		$1:ROUTE_ID::NUMBER(38, 0) AS ROUTE_ID, 
		$1:FollowupCreationDate::DATE AS FollowupCreationDate, 
		$1:FollowupRoutingCreationDate::DATE AS FollowupRoutingCreationDate, 
		$1:CD_FollowUp_TAT::NUMBER(38, 0) AS CD_FollowUp_TAT, 
		$1:PARTITION::NUMBER(38, 0) AS PARTITION, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactFollowupLifeCycle/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
