CREATE OR REPLACE VIEW DBO.DimEnrolleeSupplementalIdentifier_VW
AS 
SELECT 	$1:EnrolleeSupplementalIdentifierKey::NUMBER(38, 0) AS EnrolleeSupplementalIdentifierKey, 
		$1:ENROLLEE_ID::NUMBER(38, 0) AS ENROLLEE_ID, 
		$1:IDENTIFIER::VARCHAR AS IDENTIFIER, 
		$1:SUPPLEMENTAL_IDENTIFIER_TYPE::NUMBER(38, 0) AS SUPPLEMENTAL_IDENTIFIER_TYPE, 
		$1:EnrolleeSupplementalIdentifierTypeDescription::VARCHAR AS EnrolleeSupplementalIdentifierTypeDescription, 
		$1:ANSI_SupplementalIdentifierType::VARCHAR AS ANSI_SupplementalIdentifierType, 
		$1:InsurerID::NUMBER(38, 0) AS InsurerID, 
		$1:EnrolleeSupplementalIdentifierState::VARCHAR AS EnrolleeSupplementalIdentifierState, 
		$1:EnrolleeSupplementalEffectiveDate::DATE AS EnrolleeSupplementalEffectiveDate, 
		$1:EnrolleeSupplementalTerminationDate::DATE AS EnrolleeSupplementalTerminationDate, 
		$1:PK_Hash::NUMBER(38, 0) AS PK_Hash, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimEnrolleeSupplementalIdentifier/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
