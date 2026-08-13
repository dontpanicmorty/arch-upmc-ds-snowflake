CREATE OR REPLACE VIEW DBO.DimAuthorizationType_VW
AS 
SELECT 	$1:AuthorizationTypeKey::NUMBER(38, 0) AS AuthorizationTypeKey, 
		$1:AuthorizationServiceStatusID::NUMBER(38, 0) AS AuthorizationServiceStatusID, 
		$1:AuthorizationServiceStatusDescription::VARCHAR AS AuthorizationServiceStatusDescription, 
		$1:AuthorizationCategoryID::NUMBER(38, 0) AS AuthorizationCategoryID, 
		$1:AuthorizationCategoryDescription::VARCHAR AS AuthorizationCategoryDescription, 
		$1:AuthorizationTypeID::NUMBER(38, 0) AS AuthorizationTypeID, 
		$1:AuthorizationTypeDescription::VARCHAR AS AuthorizationTypeDescription, 
		$1:AuthorizationGroupTypeID::NUMBER(38, 0) AS AuthorizationGroupTypeID, 
		$1:AuthorizationGroupTypeDescription::VARCHAR AS AuthorizationGroupTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

