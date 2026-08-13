CREATE OR REPLACE VIEW DBO.DimSubscriberContractType_VW
AS 
SELECT 	$1:SubscriberContractTypeKey::NUMBER(38, 0) AS SubscriberContractTypeKey, 
		$1:SUBSCRIBER_CONTRACT_TYPE::NUMBER(38, 0) AS SUBSCRIBER_CONTRACT_TYPE, 
		$1:SubscriberContractTypeDescription::VARCHAR AS SubscriberContractTypeDescription, 
		$1:SubscriberContractTypeDefinition::VARCHAR AS SubscriberContractTypeDefinition, 
		$1:ANSI_CoverageLevel::VARCHAR AS ANSI_CoverageLevel, 
		$1:MinEmployeeCount::NUMBER(38, 0) AS MinEmployeeCount, 
		$1:MaxEmployeeCount::NUMBER(38, 0) AS MaxEmployeeCount, 
		$1:MinSpouseCount::NUMBER(38, 0) AS MinSpouseCount, 
		$1:MaxSpouseCount::NUMBER(38, 0) AS MaxSpouseCount, 
		$1:MinDependentCount::NUMBER(38, 0) AS MinDependentCount, 
		$1:MaxDependentCount::NUMBER(38, 0) AS MaxDependentCount, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSubscriberContractType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
