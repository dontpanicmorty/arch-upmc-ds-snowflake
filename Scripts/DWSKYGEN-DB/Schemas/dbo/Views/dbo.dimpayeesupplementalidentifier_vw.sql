CREATE OR REPLACE VIEW DBO.DimPayeeSupplementalIdentifier_VW
AS 
SELECT 	$1:PayeeSupplementalIdentifierKey::NUMBER(38, 0) AS PayeeSupplementalIdentifierKey, 
		$1:PSI_ID::VARCHAR AS PSI_ID, 
		$1:PayeeID::NUMBER(38, 0) AS PayeeID, 
		$1:PayeeIdentifierType::NUMBER(38, 0) AS PayeeIdentifierType, 
		$1:PayeeIdentifierTypeDescription::VARCHAR AS PayeeIdentifierTypeDescription, 
		$1:IdentificationNumber::VARCHAR AS IdentificationNumber, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPayeeSupplementalIdentifier/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
