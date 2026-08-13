CREATE OR REPLACE VIEW DBO.DimMaterialAllowanceFormula_VW
AS 
SELECT 	$1:MaterialAllowanceFormulaKey::NUMBER(38, 0) AS MaterialAllowanceFormulaKey, 
		$1:MATERIAL_ALLOWANCE_FORMULA_ID::NUMBER(38, 0) AS MATERIAL_ALLOWANCE_FORMULA_ID, 
		$1:MaterialAllowanceFormulaDescription::VARCHAR AS MaterialAllowanceFormulaDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimMaterialAllowanceFormula/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
