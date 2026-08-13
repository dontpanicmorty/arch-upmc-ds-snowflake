CREATE OR REPLACE VIEW DBO.DimPlaceOfService_VW
AS 
SELECT 	$1:PlaceOfServiceKey::NUMBER(38, 0) AS PlaceOfServiceKey, 
		$1:PLACE_OF_SERVICE::NUMBER(38, 0) AS PLACE_OF_SERVICE, 
		$1:PlaceOfServiceDescription::VARCHAR AS PlaceOfServiceDescription, 
		$1:PLACE_OF_SERVICE_TYPE::NUMBER(38, 0) AS PLACE_OF_SERVICE_TYPE, 
		$1:PlaceOfServiceTypeDescription::VARCHAR AS PlaceOfServiceTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPlaceOfService/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
