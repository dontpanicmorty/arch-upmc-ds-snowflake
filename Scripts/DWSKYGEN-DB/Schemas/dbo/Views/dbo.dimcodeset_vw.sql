CREATE OR REPLACE VIEW DBO.DimCodeSet_VW
AS 
SELECT 	$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:CODESET_ID::NUMBER(38, 0) AS CODESET_ID, 
		$1:CodeSetDescription::VARCHAR AS CodeSetDescription, 
		$1:CodesetClassification::NUMBER(38, 0) AS CodesetClassification, 
		$1:CodesetClassificationDescription::VARCHAR AS CodesetClassificationDescription, 
		$1:CodesetCategory::NUMBER(38, 0) AS CodesetCategory, 
		$1:CodesetCategoryDescription::VARCHAR AS CodesetCategoryDescription, 
		$1:VisionBenefitID::NUMBER(38, 0) AS VisionBenefitID, 
		$1:VisionBenefitDescription::VARCHAR AS VisionBenefitDescription, 
		$1:VisionCodeCategory::NUMBER(38, 0) AS VisionCodeCategory, 
		$1:VisionCodeCategoryDescription::VARCHAR AS VisionCodeCategoryDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCodeSet/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
