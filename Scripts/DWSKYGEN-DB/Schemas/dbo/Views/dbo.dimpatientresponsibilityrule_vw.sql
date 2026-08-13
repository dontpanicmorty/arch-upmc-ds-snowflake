CREATE OR REPLACE VIEW DBO.DimPatientResponsibilityRule_VW
AS 
SELECT 	$1:PatientResponsibilityRuleKey::NUMBER(38, 0) AS PatientResponsibilityRuleKey, 
		$1:PATIENT_RESPONSIBILITY_RULE_ID::NUMBER(38, 0) AS PATIENT_RESPONSIBILITY_RULE_ID, 
		$1:PatientResponsibilityRuleDescription::VARCHAR AS PatientResponsibilityRuleDescription, 
		$1:InsurerFlag::BOOLEAN AS InsurerFlag, 
		$1:StateSpecificFlag::BOOLEAN AS StateSpecificFlag, 
		$1:ExceptionCodeFlag::BOOLEAN AS ExceptionCodeFlag, 
		$1:ReasonCodeFlag::BOOLEAN AS ReasonCodeFlag, 
		$1:ProcedureCodeFlag::BOOLEAN AS ProcedureCodeFlag, 
		$1:ProductBrandFlag::BOOLEAN AS ProductBrandFlag, 
		$1:ProductFlag::BOOLEAN AS ProductFlag, 
		$1:PatientResponsibilityRuleNotes::VARCHAR AS PatientResponsibilityRuleNotes, 
		$1:PaymentNote::VARCHAR AS PaymentNote, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPatientResponsibilityRule/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
