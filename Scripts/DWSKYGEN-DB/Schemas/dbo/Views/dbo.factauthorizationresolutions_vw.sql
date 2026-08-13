CREATE OR REPLACE VIEW DBO.FactAuthorizationResolutions_VW
AS 
SELECT 	$1:DenialCodeKey::NUMBER(38, 0) AS DenialCodeKey, 
		$1:AUTHORIZATION_ID::NUMBER(38, 0) AS AUTHORIZATION_ID, 
		$1:EXCEPTION_NUMBER::NUMBER(38, 0) AS EXCEPTION_NUMBER, 
		$1:ExceptionDetails::VARCHAR AS ExceptionDetails, 
		$1:ResolutionInfo::VARCHAR AS ResolutionInfo, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactAuthorizationResolutions/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
