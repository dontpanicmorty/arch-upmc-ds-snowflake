CREATE OR REPLACE VIEW DBO.DimFollowUpStatus_VW
AS 
SELECT 	$1:FollowUpStatusKey::NUMBER(38, 0) AS FollowUpStatusKey, 
		$1:FOLLOWUP_STATUS::NUMBER(38, 0) AS FOLLOWUP_STATUS, 
		$1:FollowUpStatusDescription::VARCHAR AS FollowUpStatusDescription, 
		$1:FollowUpStatusGroupID::NUMBER(38, 0) AS FollowUpStatusGroupID, 
		$1:FollowUpStatusGroupDescription::VARCHAR AS FollowUpStatusGroupDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimFollowUpStatus/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
