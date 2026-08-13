CREATE OR REPLACE VIEW DBO.DimLocationSupplemental_VW
AS 
SELECT 	$1:LocationSupplementalKey::NUMBER(38, 0) AS LocationSupplementalKey, 
		$1:LOCATION_ID::NUMBER(38, 0) AS LOCATION_ID, 
		$1:LSI_ID::VARCHAR AS LSI_ID, 
		$1:LocationSupplementalIdentificationNumber::VARCHAR AS LocationSupplementalIdentificationNumber, 
		$1:LocationSupplementalIdentifierTypeID::NUMBER(38, 0) AS LocationSupplementalIdentifierTypeID, 
		$1:LocationSupplementalIndentifierTypeDescription::VARCHAR AS LocationSupplementalIndentifierTypeDescription, 
		$1:LocationSupplementalActionFlag::BOOLEAN AS LocationSupplementalActionFlag, 
		$1:LocationSupplementalStatusFlag::BOOLEAN AS LocationSupplementalStatusFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimLocationSupplemental/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

