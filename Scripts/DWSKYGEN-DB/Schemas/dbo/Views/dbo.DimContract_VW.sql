CREATE OR REPLACE VIEW DBO.DimContract_VW
AS 
SELECT 	$1:ContractKey::NUMBER(38, 0) AS ContractKey, 
		$1:CONTRACT_ID::NUMBER(38, 0) AS CONTRACT_ID, 
		$1:ContractDescription::VARCHAR AS ContractDescription, 
		$1:ContractName::VARCHAR AS ContractName, 
		$1:OriginalContractID::NUMBER(38, 0) AS OriginalContractID, 
		$1:OriginalExecutionDate::TIMESTAMP_NTZ AS OriginalExecutionDate, 
		$1:OriginalEffectiveDate::TIMESTAMP_NTZ AS OriginalEffectiveDate, 
		$1:TerminationDate::TIMESTAMP_NTZ AS TerminationDate, 
		$1:ActiveFlag::BOOLEAN AS ActiveFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimContract/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
