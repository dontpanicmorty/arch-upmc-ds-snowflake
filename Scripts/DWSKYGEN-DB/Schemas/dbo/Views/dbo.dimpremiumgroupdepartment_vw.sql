CREATE OR REPLACE VIEW DBO.DimPremiumGroupDepartment_VW
AS 
SELECT 	$1:PremiumGroupDepartmentKey::NUMBER(38, 0) AS PremiumGroupDepartmentKey, 
		$1:PREMIUM_GROUP_DEPARTMENT_ID::NUMBER(38, 0) AS PREMIUM_GROUP_DEPARTMENT_ID, 
		$1:PremiumGroupDepartmentDescription::VARCHAR AS PremiumGroupDepartmentDescription, 
		$1:PremiumGroupUnitID::NUMBER(38, 0) AS PremiumGroupUnitID, 
		$1:PremiumGroupUnitDescription::VARCHAR AS PremiumGroupUnitDescription, 
		$1:PremiumGroupDivisionID::NUMBER(38, 0) AS PremiumGroupDivisionID, 
		$1:PremiumGroupDivisionDescription::VARCHAR AS PremiumGroupDivisionDescription, 
		$1:PremiumGroupID::NUMBER(38, 0) AS PremiumGroupID, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPremiumGroupDepartment/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
