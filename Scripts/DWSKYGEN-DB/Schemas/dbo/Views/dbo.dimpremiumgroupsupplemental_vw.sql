CREATE OR REPLACE VIEW DBO.DimPremiumGroupSupplemental_VW
AS 
SELECT 	$1:PremiumGroupSupplementalKey::NUMBER(38, 0) AS PremiumGroupSupplementalKey, 
		$1:PLAN_PERIOD_SUPPLEMENTAL_INFO_ID::NUMBER(38, 0) AS PLAN_PERIOD_SUPPLEMENTAL_INFO_ID, 
		$1:PlanPeriodSupplementalDescription::VARCHAR AS PlanPeriodSupplementalDescription, 
		$1:ControlDataStatus::NUMBER(38, 0) AS ControlDataStatus, 
		$1:ControlDataStatusDescription::VARCHAR AS ControlDataStatusDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPremiumGroupSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
