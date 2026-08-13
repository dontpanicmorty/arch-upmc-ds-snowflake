CREATE OR REPLACE VIEW DBO.DimFeature_VW
AS 
SELECT 	$1:FeatureKey::NUMBER(38, 0) AS FeatureKey, 
		$1:FEATURE_ID::NUMBER(38, 0) AS FEATURE_ID, 
		$1:FeatureDescription::VARCHAR AS FeatureDescription, 
		$1:FeatureCategoryID::NUMBER(38, 0) AS FeatureCategoryID, 
		$1:FeatureCategoryDescription::VARCHAR AS FeatureCategoryDescription, 
		$1:FeatureTypeID::NUMBER(38, 0) AS FeatureTypeID, 
		$1:FeatureTypeDescription::VARCHAR AS FeatureTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimFeature/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
