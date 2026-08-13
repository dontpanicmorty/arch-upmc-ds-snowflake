CREATE OR REPLACE VIEW DBO.DimBenefitPlanPeriod_VW
AS 
SELECT 	$1:BenefitPlanPeriodKey::NUMBER(38, 0) AS BenefitPlanPeriodKey, 
		$1:PRODUCT_ID::NUMBER(38, 0) AS PRODUCT_ID, 
		$1:PRODUCT_PERIOD::NUMBER(38, 0) AS PRODUCT_PERIOD, 
		$1:BenefitPlanPeriodEffectiveDate::DATE AS BenefitPlanPeriodEffectiveDate, 
		$1:BenefitPlanPeriodTerminationDate::DATE AS BenefitPlanPeriodTerminationDate, 
		$1:ReimbursementScheduleID::NUMBER(38, 0) AS ReimbursementScheduleID, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DWH_Hash::VARCHAR AS DWH_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBenefitPlanPeriod/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
