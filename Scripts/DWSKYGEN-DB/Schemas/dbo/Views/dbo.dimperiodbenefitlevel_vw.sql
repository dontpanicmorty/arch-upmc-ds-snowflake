CREATE OR REPLACE VIEW DBO.DimPeriodBenefitLevel_VW
AS 
SELECT 	$1:PeriodBenefitLevelKey::NUMBER(38, 0) AS PeriodBenefitLevelKey, 
		$1:PRODUCT_ID::NUMBER(38, 0) AS PRODUCT_ID, 
		$1:PRODUCT_PERIOD::NUMBER(38, 0) AS PRODUCT_PERIOD, 
		$1:BENEFIT_LEVEL::NUMBER(38, 0) AS BENEFIT_LEVEL, 
		$1:PeriodBenefitLevelDescription::VARCHAR AS PeriodBenefitLevelDescription, 
		$1:CoinsuranceFormula::VARCHAR AS CoinsuranceFormula, 
		$1:DeductibleFormula::VARCHAR AS DeductibleFormula, 
		$1:OOPFormula::VARCHAR AS OOPFormula, 
		$1:PaidFormula::VARCHAR AS PaidFormula, 
		$1:BenefitMaximumFormula::VARCHAR AS BenefitMaximumFormula, 
		$1:OONFlag::BOOLEAN AS OONFlag, 
		$1:AgeMin::NUMBER(38, 0) AS AgeMin, 
		$1:AgeMax::NUMBER(38, 0) AS AgeMax, 
		$1:SpecialNeedsFlag::BOOLEAN AS SpecialNeedsFlag, 
		$1:SubscriberFlag::BOOLEAN AS SubscriberFlag, 
		$1:SpouseFlag::BOOLEAN AS SpouseFlag, 
		$1:DependentsFlag::BOOLEAN AS DependentsFlag, 
		$1:ClientBenefitLevelCode::VARCHAR AS ClientBenefitLevelCode, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPeriodBenefitLevel/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
