CREATE OR REPLACE VIEW DBO.DimDomain_VW
AS 
SELECT 	$1:DomainKey::NUMBER(38, 0) AS DomainKey, 
		$1:DOMAIN_ID::NUMBER(38, 0) AS DOMAIN_ID, 
		$1:DomainName::VARCHAR AS DomainName, 
		$1:AdminUserName::VARCHAR AS AdminUserName, 
		$1:InactiveFlag::BOOLEAN AS InactiveFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDomain/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
