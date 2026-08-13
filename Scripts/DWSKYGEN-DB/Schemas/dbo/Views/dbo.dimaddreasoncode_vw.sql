CREATE OR REPLACE VIEW DBO.DimAddReasonCode_VW
AS 
SELECT 	$1:AddReasonCodeKey::NUMBER(38, 0) AS AddReasonCodeKey, 
		$1:ADD_REASON_CODE::NUMBER(38, 0) AS ADD_REASON_CODE, 
		$1:AddReasonCodeDescription::VARCHAR AS AddReasonCodeDescription, 
		$1:MaintenanceReasonCode::VARCHAR AS MaintenanceReasonCode, 
		$1:MaintenanceReasonCodeDescription::VARCHAR AS MaintenanceReasonCodeDescription, 
		$1:AddPolicyFlag::BOOLEAN AS AddPolicyFlag, 
		$1:AddDependentFlag::BOOLEAN AS AddDependentFlag, 
		$1:AddSpouseFlag::BOOLEAN AS AddSpouseFlag, 
		$1:ChangePlanFlag::BOOLEAN AS ChangePlanFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAddReasonCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
