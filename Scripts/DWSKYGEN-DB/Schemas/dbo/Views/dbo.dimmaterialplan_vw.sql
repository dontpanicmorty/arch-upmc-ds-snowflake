CREATE OR REPLACE VIEW DBO.DimMaterialPlan_VW
AS 
SELECT 	$1:MaterialPlanKey::NUMBER(38, 0) AS MaterialPlanKey, 
		$1:MATERIAL_PLAN_ID::NUMBER(38, 0) AS MATERIAL_PLAN_ID, 
		$1:MaterialPlanDescription::VARCHAR AS MaterialPlanDescription, 
		$1:MaterialMaximumFormulaID::NUMBER(38, 0) AS MaterialMaximumFormulaID, 
		$1:MaterialMaximumFormulaDescription::VARCHAR AS MaterialMaximumFormulaDescription, 
		$1:MaterialCoinsuranceFormulaID::NUMBER(38, 0) AS MaterialCoinsuranceFormulaID, 
		$1:MaterialCoinsuranceFormulaDescription::VARCHAR AS MaterialCoinsuranceFormulaDescription, 
		$1:MaterialDeductibleFormulaID::NUMBER(38, 0) AS MaterialDeductibleFormulaID, 
		$1:MaterialDeductibleFormulaDescription::VARCHAR AS MaterialDeductibleFormulaDescription, 
		$1:MaterialOOPFormulaID::NUMBER(38, 0) AS MaterialOOPFormulaID, 
		$1:MaterialOOPFormulaDescription::VARCHAR AS MaterialOOPFormulaDescription, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		$1:RecordStartDate::DATE AS RecordStartDate
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimMaterialPlan/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
