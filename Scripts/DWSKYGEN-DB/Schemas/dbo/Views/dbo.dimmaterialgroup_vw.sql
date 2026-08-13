CREATE OR REPLACE VIEW DBO.DimMaterialGroup_VW
AS 
SELECT 	$1:MaterialGroupKey::NUMBER(38, 0) AS MaterialGroupKey, 
		$1:MATERIAL_GROUP_ID::NUMBER(38, 0) AS MATERIAL_GROUP_ID, 
		$1:MaterialGroupDescription::VARCHAR AS MaterialGroupDescription, 
		$1:MaterialGroupTypeID::NUMBER(38, 0) AS MaterialGroupTypeID, 
		$1:MaterialGroupTypeDescription::VARCHAR AS MaterialGroupTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimMaterialGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
