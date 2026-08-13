CREATE OR REPLACE VIEW DBO.DimRolloverBenefitProcessing_VW
AS 
SELECT 	$1:RolloverBenefitProcessingKey::NUMBER(38, 0) AS RolloverBenefitProcessingKey, 
		$1:ROLLOVER_BENEFIT_ID::NUMBER(38, 0) AS ROLLOVER_BENEFIT_ID, 
		$1:PRODUCT_ID::NUMBER(38, 0) AS PRODUCT_ID, 
		$1:PREMIUM_GROUP_ID::NUMBER(38, 0) AS PREMIUM_GROUP_ID, 
		$1:PlanYearStart::DATE AS PlanYearStart, 
		$1:PlanYearEnd::DATE AS PlanYearEnd, 
		$1:MeasurementDate::DATE AS MeasurementDate, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimRolloverBenefitProcessing/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
