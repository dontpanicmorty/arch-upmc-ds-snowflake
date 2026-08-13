CREATE OR REPLACE VIEW DBO.DimPortal_VW
AS 
SELECT 	$1:PortalKey::NUMBER(38, 0) AS PortalKey, 
		$1:PORTAL_ID::NUMBER(38, 0) AS PORTAL_ID, 
		$1:PortalName::VARCHAR AS PortalName, 
		$1:LineOfBusinessID::NUMBER(38, 0) AS LineOfBusinessID, 
		$1:LineOfBusinessDescription::VARCHAR AS LineOfBusinessDescription, 
		$1:PortalTypeID::NUMBER(38, 0) AS PortalTypeID, 
		$1:PortalTypeName::VARCHAR AS PortalTypeName, 
		$1:PortalTypeDescription::VARCHAR AS PortalTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPortal/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

