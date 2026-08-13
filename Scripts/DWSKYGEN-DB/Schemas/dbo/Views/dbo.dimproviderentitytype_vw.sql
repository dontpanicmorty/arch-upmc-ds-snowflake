CREATE OR REPLACE VIEW DBO.DimProviderEntityType_VW
AS 
SELECT 	$1:ProviderEntityTypeKey::NUMBER(38, 0) AS ProviderEntityTypeKey, 
		$1:PROVIDER_ENTITY_TYPE::NUMBER(38, 0) AS PROVIDER_ENTITY_TYPE, 
		$1:ProviderEntityTypeDescription::VARCHAR AS ProviderEntityTypeDescription, 
		$1:SpecialtyID::NUMBER(38, 0) AS SpecialtyID, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		$1:RecordStartDate::DATE AS RecordStartDate
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimProviderEntityType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
