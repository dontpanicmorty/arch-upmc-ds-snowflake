CREATE OR REPLACE VIEW DBO.DimDocument_VW
AS 
SELECT 	$1:DocumentKey::NUMBER(38, 0) AS DocumentKey, 
		$1:DOCUMENT_ID::NUMBER(38, 0) AS DOCUMENT_ID, 
		$1:FileName::VARCHAR AS FileName, 
		$1:AllowDeleteFlag::BOOLEAN AS AllowDeleteFlag, 
		$1:WebAccessProvidersFlag::BOOLEAN AS WebAccessProvidersFlag, 
		$1:WebAccessClientsFlag::BOOLEAN AS WebAccessClientsFlag, 
		$1:WebAccessMembersFlag::BOOLEAN AS WebAccessMembersFlag, 
		$1:WebAccessPremiumGroupsFlag::BOOLEAN AS WebAccessPremiumGroupsFlag, 
		$1:WebAccessBrokersFlag::BOOLEAN AS WebAccessBrokersFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDocument/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
