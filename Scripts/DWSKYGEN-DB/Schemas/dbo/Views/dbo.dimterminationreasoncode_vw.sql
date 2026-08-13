CREATE OR REPLACE VIEW DBO.DimTerminationReasonCode_VW
AS 
SELECT 	$1:TerminationReasonCodeKey::NUMBER(38, 0) AS TerminationReasonCodeKey, 
		$1:TERMINATION_REASON_CODE::NUMBER(38, 0) AS TERMINATION_REASON_CODE, 
		$1:TerminationReasonCodeDescription::VARCHAR AS TerminationReasonCodeDescription, 
		$1:COBRAEventCode::NUMBER(38, 0) AS COBRAEventCode, 
		$1:COBRAEventCodeDescription::VARCHAR AS COBRAEventCodeDescription, 
		$1:MaintenanceReasonCode::VARCHAR AS MaintenanceReasonCode, 
		$1:MaintenanceReasonCodeDescription::VARCHAR AS MaintenanceReasonCodeDescription, 
		$1:TerminatePolicyFlag::BOOLEAN AS TerminatePolicyFlag, 
		$1:TerminateDependentFlag::BOOLEAN AS TerminateDependentFlag, 
		$1:TerminateSpouseFlag::BOOLEAN AS TerminateSpouseFlag, 
		$1:ChangePlanFlag::BOOLEAN AS ChangePlanFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimTerminationReasonCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
