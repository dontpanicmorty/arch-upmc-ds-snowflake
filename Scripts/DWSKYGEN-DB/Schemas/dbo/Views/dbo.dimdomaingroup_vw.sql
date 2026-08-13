CREATE OR REPLACE VIEW DBO.DimDomainGroup_VW
AS 
SELECT 	$1:DomainGroupKey::NUMBER(38, 0) AS DomainGroupKey, 
		$1:DOMAIN_GROUP_ID::NUMBER(38, 0) AS DOMAIN_GROUP_ID, 
		$1:DOMAIN_ID::NUMBER(38, 0) AS DOMAIN_ID, 
		$1:DomainGroupDescription::VARCHAR AS DomainGroupDescription, 
		$1:DomainGroupName::VARCHAR AS DomainGroupName, 
		$1:LoginEntityTypeID::NUMBER(38, 0) AS LoginEntityTypeID, 
		$1:LoginEntityTypeDescription::VARCHAR AS LoginEntityTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDomainGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
